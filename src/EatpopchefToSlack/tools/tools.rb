module EatpopchefToSlack
  class Tools
    class << self
      def root_path
        @root_path ||= File.expand_path(File.join(__dir__, '..', '..', '..'))
      end

      def database
        @database ||= EatpopchefToSlack::Database.new
      end

      def config
        @config ||= YAML.load_file(File.join(root_path, 'config', 'config.yml'))
      end

      def logger
        @logger ||= Logger.new(File.join(root_path, 'logs', 'log.txt'))
      end
    end
  end
end
