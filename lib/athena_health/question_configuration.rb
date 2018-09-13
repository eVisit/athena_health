module AthenaHealth
  class QuestionConfiguration < BaseModel
    attribute :questionid,    Integer
    attribute :question,      String
    attribute :diagnosiscode, String
    attribute :deleted,       Boolean
    attribute :ordering,      Integer
  end
end
