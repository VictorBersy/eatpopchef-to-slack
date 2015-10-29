module EatpopchefToSlack
  module Eatpopchef
    class Eatpopchef
      def initialize
        retrieve_menu(Tools.config['eatpopchef']['schedules']['now'])
      end

      private

      def retrieve_menu(url)
        zone_id = Tools.config['eatpopchef']['schedules']['zone_id']
        zone_url = url + "?zoneId=#{zone_id}"
        json_data = JSON.load(open(zone_url))
        split_data(json_data)
      end

      def split_data(json_data)
        pre_formatted_data = {
          dishes: json_data['dishes'],
          sides: json_data['sides']
        }
        pre_formatted_data.each do |key, plates|
          plates.each do |plate|
            dispatch_message(key, plate)
          end
        end
      end

      def dispatch_message(key, plate)
        params = { type: key }
        EatpopchefToSlack::Message::Dispatcher.new(plate, params)
      end
    end
  end
end
