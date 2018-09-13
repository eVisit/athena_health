require 'spec_helper'

describe AthenaHealth::Severity do
  let(:severity_attributes) do
    {
      'snomedcode': '371923003',
      'severity': 'mild to moderate'
    }
  end

  subject { AthenaHealth::Severity.new(severity_attributes) }

  it_behaves_like 'a model'

  it 'have proper attributes' do
    expect(subject).to have_attributes(
      snomedcode: 371923003,
      severity: 'mild to moderate'
    )
  end
end
