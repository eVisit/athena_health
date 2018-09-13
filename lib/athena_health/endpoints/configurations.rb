module AthenaHealth
  module Endpoints
    module Configurations
      def all_facilities(practice_id:, department_id:, order_type:, params: {})
        response = @api.call(
          endpoint: "#{practice_id}/chart/configuration/facilities",
          method: :get,
          params: params.merge!(departmentid: department_id, ordertype: order_type)
        )

        response.map {|facility| AthenaHealth::Facility.new(facility) }
      end

      def all_medications(practice_id:, search_value:)
        response = @api.call(
          endpoint: "#{practice_id}/reference/medications",
          method: :get,
          params: { searchvalue: search_value }
        )

        response.map {|medication| AthenaHealth::Medication.new(medication) }
      end

      def all_allergies(practice_id:, search_value:)
        response = @api.call(
          endpoint: "#{practice_id}/reference/allergies",
          method: :get,
          params: { searchvalue: search_value }
        )

        response.map {|allergy| AthenaHealth::Allergy.new(allergy) }
      end

      def all_insurances(practice_id:, plan_name:, member_id:, state:, params: {})
        response = @api.call(
          endpoint: "#{practice_id}/insurancepackages",
          method: :get,
          params: params.merge!(
            insuranceplanname: plan_name,
            memberid: member_id,
            stateofcoverage: state
          )
        )

        AthenaHealth::InsuranceCollection.new(response)
      end

      # eVisit methods
      def all_question_configuration(practice_id:)
        response = @api.call(
          endpoint: "#{practice_id}/chart/configuration/medicalhistory",
          method: :get
        )

        # TODO: use QuestionConfigurationCollection
        response['questions'].map { |question_config| QuestionConfiguration.new(question_config) }
      end

      # eVisit methods
      def all_allergies_reactions(practice_id:)
        response = @api.call(
          endpoint: "#{practice_id}/reference/allergies/reactions",
          method: :get
        )

        # TODO: use ReactionCollection
        response.map  {|allergy_reaction| Reaction.new(allergy_reaction) }
      end

      # eVisit methods
      def all_allergies_severities(practice_id:)
        response = @api.call(
          endpoint: "#{practice_id}/reference/allergies/severities",
          method: :get
        )

        # TODO: use SeverityCollection
        response.map { |allergy_severity| Severity.new(allergy_severity) }
      end

      # eVisit methods
      def all_nonccp_methods(practice_id:)
        response = @api.call(
          endpoint: "#{practice_id}/configuration/validnonccpcreditcardmethods",
          method: :get
        )

        response['paymentmethods']
      end

    end
  end
end
