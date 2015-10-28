module EatpopchefToSlack
  module Message
    module Formatter
      class SlackFormatter
        def initialize(data)
          @data = data
        end

        def format
          {
            link: format_link_message,
            attachment: format_attachment
          }
        end

        private

        def color_by_type(type)
          colors = { dishes: '#DF9230', sides: '#BF496A' }
          colors[type.to_sym]
        end

        def format_link_message
          type = "#{@data[:type_human]} :"

          "#{type} #{@data[:title]} (#{@data[:price]}€) "\
          "[#{@data[:quantity]}/#{@data[:quantityAvailable]} available]"
        end

        def format_attachment
          {
            fallback: "#{@data[:type]} #{@data[:title]}",
            color: color_by_type(@data[:type]),
            title: @data[:title],
            title_link: @data[:picture],
            fields: [
              { title: 'Description', value: @data[:description] },
              { title: 'Prix', value: "#{@data[:price]}€", short: true },
              { title: 'Quantité', value: @data[:quantity], short: true },
              { title: 'Restants', value: @data[:quantityAvailable],
                short: true },
            ],
            thumb_url: @data[:picture]
          }
        end
      end
    end
  end
end
