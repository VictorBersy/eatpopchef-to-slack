module EatpopchefToSlack
  module Message
    class Dispatcher
      def initialize(plate, params = {})
        @plate = plate
        @plate[:type] = params[:type]
        dispatch
      end

      def dispatch
        to_services.each do |sender_name|
          formatter = EatpopchefToSlack::Message::Formatter::Formatter
                      .new(@plate, sender_name)
          message = formatter.format_message
          sender = sender_instance(sender_name, @plate[:type])
          sender.send(message)
        end
      end

      private

      def to_services
        Tools.config['services']['enabled'].map(&:to_sym)
      end

      def sender_instance(to, type)
        class_name = 'EatpopchefToSlack::Message::Sender::'
        class_name += "#{to.downcase.capitalize}Sender"
        Object.const_get(class_name).new(type)
      end
    end
  end
end
