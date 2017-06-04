require 'bundler'
Bundler.require

require './app'

Dotenv.load

Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUD_NAME']
  config.api_key    = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_API_SECRET']
end

RakutenWebService.configure do |config|
  config.application_id = '1046263700459029333'
  config.affiliate_id = '15bce942.1c7b8cd8.15bce943.eeea3e1b'
end

run Sinatra::Application
