require 'spec_helper'

describe AthenaHealth::QuestionConfiguration do
  let(:question_configuration_attributes) do
    {
      'questionid': '101',
      'question': 'dementia',
      'diagnosiscode': '23244',
      'deleted': 'ABCD',
      'ordering': '11'
    }
  end

  subject { AthenaHealth::QuestionConfiguration.new(question_configuration_attributes) }

  it_behaves_like 'a model'

  it 'have proper attributes' do
    expect(subject).to have_attributes(
      questionid: 101,
      question: 'dementia',
      diagnosiscode: '23244',
      deleted: 'ABCD',
      ordering: 11
    )
  end
end
