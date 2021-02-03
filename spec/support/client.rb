def client_attributes
  {
    version:   'preview1',
    key:       (ENV['ATHENA_TEST_KEY'] || 'test_key'),
    secret:    (ENV['ATHENA_TEST_SECRET'] || 'test_secret'),
    token:     (ENV['ATHENA_TEST_ACCESS_TOKEN'] || 'test_access_token'),
    base_url:  (ENV['ATHENA_TEST_BASE_URL'] || 'https://api.athenahealth.com'),
    auth_path: (ENV['ATHENA_TEST_AUTH_PATH'] || { 'v1' => 'oauth', 'preview1' => 'oauthpreview', 'openpreview1' => 'oauthopenpreview' })
  }
end

def client
  AthenaHealth::Client.new(client_attributes)
end
