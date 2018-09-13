module AthenaHealth
  class ValidationError < StandardError
    attr_reader :details
    @@logger = defined?(Rails) ? :rails_logger : :stdout_logger

    def initialize(details)
      @details = details

      log " >>> Athena ValidationError START <<<"
      log @details.inspect
      log " >>> Athena ValidationError END <<<"
    end

    def log(str)
      self.send(@@logger, str)
    end

    def rails_logger(str)
      Rails.logger.info str
    end

    def stdout_logger(str)
      puts str
    end
  end
end
