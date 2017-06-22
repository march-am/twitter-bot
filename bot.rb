require 'twitter'
require 'csv'
require 'pry'
require 'dotenv'
Dotenv.load

class TwitterUser
  attr_reader :client

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_SECRET']
    end
  end
end

class FollowMaganer
  attr_writer :user

  def initialize(user)
    @user = user
  end

  def refollow_all
    followed = []
    @user.followers.each do |follower|
      unless @user.friends.include?(follower)
        unless @user.friendships_outgoing.include?(follower)
          Twitter.follow(follower)
          followed << follower
        end
      end
    end
    followed
  end

  # 一方的にフォローしているユーザをリムーブ
  def unfollow_all
    unfollowed = []
    @user.friends.each do |friend|
      unless @user.followers.include?(friend)
        Twitter.unfollow(friend)
        unfollowed << friend
      end
    end
    unfollowed
  end
end

class TweetManager
  attr_writer :user

  def initialize(user)
    @user = user
  end

  def scheduled_tweets
    # Tweet something
    # tweeted
  end
end

class ScheduleLoader

end

user   = TwitterUser.new
follow = FollowMaganer.new(user)
tweet  = TweetMaganer.new(user)

followed = follow.refollow_all
tweeted  = tweet.scheduled_tweets

### output ###

puts "at #{Time.now.to_s}"
if followed
  puts 'Followed:'
  p followed.map { |f| f.name }.join(', ')
elsif unfollowed
  puts 'Unfollowed:'
  p unfollowed.map { |f| f.name }.join(', ')
elsif tweeted
  puts 'Tweeted:'
  p tweeted.map { |f| f.text }
else
  puts 'did nothing'
end
