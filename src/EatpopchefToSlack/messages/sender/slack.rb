module EatpopchefToSlack
  module Message
    module Sender
      class SlackSender
        def initialize(type)
          @type = type
          @slack_client = create_slack_client
        end

        def send(message)
          params = { attachments: [message[:attachment]] }
          @slack_client.ping('', params)
        end

        def create_slack_client
          slack_params = method("#{@type}_params".to_sym).call
          webhook_url = Tools.config['slack']['webhook_url']
          Slack::Notifier.new webhook_url, slack_params
        end

        def dishes_params
          {
            username: full_username('dishes'),
            channel: Tools.config['slack']['channel'],
            icon_emoji: Tools.config['slack']['dishes']['emoji']
          }
        end

        def sides_params
          {
            username: full_username('sides'),
            channel: Tools.config['slack']['channel'],
            icon_emoji: Tools.config['slack']['sides']['emoji']
          }
        end

          private

        def full_username(type)
          username_suffix = Tools.config['slack'][type]['username_suffix']
          username = Tools.config['slack']['username']
          [username, username_suffix].join(' - ')
        end
      end
    end
  end
end
