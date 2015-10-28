module EatpopchefToSlack
  module Message
    module Formatter
      class LogFormatter
        def initialize(data)
          @data = data
        end

        def format
          { raw: raw_message, colored: colored_message }
        end

        private

        def raw_message
          type = "#{@data[:type_human]} :"

          "#{type} #{@data[:title]} (#{@data[:price]}€) "\
          "[#{@data[:quantity]}/#{@data[:quantityAvailable]} available]"
        end

        def colored_message
          type = color_by_type(@data[:type], "#{@data[:type_human]} :")
          price = Rainbow("#{@data[:price]}€").green

          "#{type} #{@data[:title]} (#{price}) "\
          "[#{@data[:quantity]}/#{@data[:quantityAvailable]} available]"
        end

        def color_by_type(type, txt)
          colors = { dishes: :yellow, sides: :cyan }
          Rainbow(txt).send(colors[type])
        end
      end
    end
  end
end
