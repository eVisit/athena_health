require 'spec_helper'

describe AthenaHealth::Connection do
  let(:connection_attributes) do
    {
      version: version,
      key: 'test_key',
      secret: 'test_secret'
    }
  end

  let(:connection) { AthenaHealth::Connection.new(connection_attributes) }

  it 'has defined BASE_URL constant' do
    expect(AthenaHealth::Connection::BASE_URL)
      .to eq 'https://api.athenahealth.com'
  end

  context 'when base_url is not defined' do
    let(:connection_attributes) do
      {
        version: 'v1',
        key: 'test_key',
        secret: 'test_secret'
      }
    end

    it 'base_url defaults to constant BASE_URL' do
      expect(connection.instance_variable_get(:@base_url))
        .to eq AthenaHealth::Connection::BASE_URL
    end
  end

  context 'when base_url is defined' do
    let(:connection_attributes) do
      {
        version: 'v1',
        key: 'test_key',
        secret: 'test_secret',
        base_url: 'https://apitest.athenahealth.com'
      }
    end

    it 'base_url overrides constant BASE_URL' do
      expect(connection.instance_variable_get(:@base_url))
        .to eq 'https://apitest.athenahealth.com'
    end
  end

  it 'has defined AUTH_PATH constant' do
    expect(AthenaHealth::Connection::AUTH_PATH)
      .to eq(
        'v1' => 'oauth',
        'preview1' => 'oauthpreview',
        'openpreview1' => 'oauthopenpreview'
      )
  end

  context 'when auth_path is defined' do
    let(:connection_attributes) do
      {
        version: 'v1',
        key: 'test_key',
        secret: 'test_secret',
        auth_path: { 'v1' => 'oauth2/v1' }
      }
    end

    it 'auth_path overrides constant AUTH_PATH' do
      expect(connection.instance_variable_get(:@auth_path))
        .to eq({ 'v1' => 'oauth2/v1' })
    end
  end

  describe '#authenticate' do
    context 'when version is v1' do
      let(:version) { 'v1' }

      it 'returns token' do
        VCR.use_cassette('v1_authentication') do
          expect(connection.authenticate).to eq 'test_access_token'
        end
      end
    end

    context 'when version is preview1' do
      let(:version) { 'preview1' }

      it 'returns token' do
        VCR.use_cassette('preview1_authentication') do
          expect(connection.authenticate).to eq 'test_access_token'
        end
      end
    end

    context 'when version is openpreview1' do
      let(:version) { 'openpreview1' }

      it 'returns token' do
        VCR.use_cassette('openpreview1_authentication') do
          expect(connection.authenticate).to eq 'test_access_token'
        end
      end
    end
  end

  describe '#authenticate with custom url and version' do
    context 'when version is v1' do
      let(:connection_attributes) do
        {
          version: 'v1',
          key: 'test_key',
          secret: 'test_secret',
          base_url: 'https://api.preview.platform.athenahealth.com',
          auth_path: { 'v1' => 'oauth2/v1' }
        }
      end

      it 'returns token' do
        VCR.use_cassette('v1_authentication_custom') do
          expect(connection.authenticate).to eq 'test_access_token_custom'
        end
      end
    end
  end

  describe '#call' do
    let(:version)       { 'preview1' }
    let(:response_body) { '{"body":"value"}' }
    let(:request)       { instance_double(Typhoeus::Request) }

    let(:response) do
      instance_double(
        Typhoeus::Response,
        response_code: response_code,
        response_body: response_body
      )
    end

    before do
      allow(connection).to receive(:authenticate) do
        connection.instance_variable_set(:@token, 'test_access_token')
      end

      expect(Typhoeus::Request).to receive(:new).with(
        'https://api.athenahealth.com/preview1/test_endpoint',
        method: :get,
        headers: { 'Authorization' => 'Bearer test_access_token' },
        params: {},
        body: {}
      ) { request }

      expect(request).to receive(:run) { response }
    end

    context 'when response_code is 200' do
      let(:response_code) { 200 }

      it 'returns parsed response_body' do
        expect(connection.call(endpoint: 'test_endpoint', method: :get))
          .to eq JSON.parse(response_body)
      end
    end

    context 'when response_code is not 200' do
      let(:response_code) { 404 }

      it 'returns error' do
        expect { connection.call(endpoint: 'test_endpoint', method: :get) }
          .to raise_error(AthenaHealth::NotFoundError)
      end
    end
  end
end
