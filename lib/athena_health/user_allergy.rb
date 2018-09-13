module AthenaHealth
  class UserAllergy < BaseModel
    attribute :allergenid,     Integer
    attribute :allergenname,   String
    attribute :onsetdate,      String
    attribute :deactivatedate, String
    attribute :note,           String
    attribute :reactions,      Array[Reaction]
  end
end
