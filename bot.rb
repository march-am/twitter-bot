require 'csv'
require 'twitter'
require 'dotenv'
require 'pry'

Dotenv.load
Twitter.configure do |c|
  c.consumer_key       = config['CONSUMER_KEY']
  c.consumer_secret    = config['CONSUMER_SECRET']
  c.oauth_token        = config['ACCESS_TOKEN']
  c.oauth_token_secret = config['ACCESS_SECRET']
end

class TwitterUser
  attr_accessor :followers, :friends, :pending_users
  def initialize
    @followers     = Twitter.follower_ids.collection
    @friends       = Twitter.friend_ids.collection
    @pending_users = Twitter.friendships_outgoing.collection
  end
end

class FollowMaganer
  def initialize(user)
    @user = user
  end

  def refollow_all
    followed = Array.new
    @user.followers.each do |follower|
      unless @user.friends.include?(follower)
        unless @user.pending_users.include?(follower)
          Twitter.follow(follower)
          followed << follower
        end
      end
    end
    followed
  end

  # 一方的にフォローしているユーザをリムーブ
  def unfollow_all
    unfollowed = Array.new
    @user.friends.each do |friend|
      unless @user.followers.include?(friend)
        Twitter.unfollow(friend)
        unfollowed << friend
      end
    end
    unfollowed
  end
end

user    = TwitterUser.new
maganer = FollowMaganer.new(user)

followed = manager.refollow_all

puts Time.now.to_s+" followed"
p followed