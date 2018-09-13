module AthenaHealth
  class UserAllergyCollection < BaseModel
    attribute :allergies,   Array[UserAllergy]
    attribute :lastupdated, String
    attribute :nkda,        Boolean
    attribute :sectionnote, String
  end
end
