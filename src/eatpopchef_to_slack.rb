$LOAD_PATH << File.dirname(__FILE__)

module EatpopchefToSlack
  require 'open-uri'
  require 'json'
  require 'yaml'
  require 'slack-notifier'
  require 'logger'
  require 'rainbow'
  require 'metainspector'

  require 'EatpopchefToSlack/boot/loader'
  Boot::Boot.new
end
