class TweetManager
  include Retry

  def initialize(user)
    @user = user
  end

  def scheduled_tweets
    tweeted = []
    twitter_retry do
      tweet_text = load_tweet
      tweet = @user.update(tweet_text)
      tweeted << tweet
    end
    tweeted
  end

  def load_tweet

  end
end
