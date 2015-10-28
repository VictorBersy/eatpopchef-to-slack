module EatpopchefToSlack
  module Boot
    class Boot
      def initialize
        Tools.logger.debug "Starting script at #{Time.now.utc}"
        Eatpopchef::Eatpopchef.new
      end
    end
  end
end
