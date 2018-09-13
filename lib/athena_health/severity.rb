module AthenaHealth
  class Severity < BaseModel
    attribute :snomedcode, Integer
    attribute :severity,   String
  end
end
