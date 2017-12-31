class TweetManager
  include Retry
  attr_reader :user, :tweeted

  def initialize(user)
    @user = user.client
    @tweeted = []
  end

  def tweet_scheduled
    twitter_retry_to do
      to_tweet = load_tweet
      return unless to_tweet
      now_tweeted = user.update(to_tweet.content)
      to_tweet.update(last_tweeted_at: Time.now)
      tweeted << now_tweeted
    end
    tweeted
  end

  def load_tweet
    Schedule.nearly_now.sample
  end
end
