class TwitterUser
  include Retry
  attr_reader :client

  def initialize
    @client = client
  end

  def client
    twitter_retry_to do
      @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_SECRET']
     end
   end
  end
end
