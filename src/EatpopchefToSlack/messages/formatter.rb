module EatpopchefToSlack
  module Message
    module Formatter
      class Formatter
        def initialize(data, formatter_name)
          @agnostic_data = data_to_agnostic_format(data)
          @formatter_name = formatter_name
        end

        def format_message
          class_name = 'EatpopchefToSlack::Message::Formatter::'
          class_name += "#{@formatter_name.downcase.capitalize}Formatter"
          Object.const_get(class_name).new(@agnostic_data).format
        end

        private

        def data_to_agnostic_format(data)
          {
            id: data['id'],
            type: data[:type],
            type_human: data[:type].capitalize,
            title: data['title'],
            description: data['description'],
            picture: data['picture'],
            price: real_price_for(data),
            quantity: data['quantity'],
            quantityAvailable: data['quantityAvailable']
          }
        end

        def real_price_for(data)
          type = data[:type]
          popchef = data['price']
          enterprise = Tools.config['eatpopchef']['enterprise']['price_override'][type.to_s].to_f
          prices = [popchef, enterprise]
          prices.delete_if {|p| p.zero? }.min
        end
      end
    end
  end
end
