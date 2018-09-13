module AthenaHealth
  class BaseModel
    include Virtus.model

    def to_hash_recursive
      JSON.parse self.to_json
    end
  end
end
