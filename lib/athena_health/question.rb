module AthenaHealth
  class Question < BaseModel
    attribute :answer,        String
    attribute :key,           String
    attribute :lastupdated,   Integer
    attribute :ordering,      Integer
    attribute :templateid,    Integer
    attribute :question,      String
    attribute :questionid,    Integer
    attribute :note,          String
    attribute :diagnosiscode, String
    attribute :codeset,       String
    attribute :description,   String
  end
end
