class TweetManager
  include Retry
  attr_reader :user, :tweeted

  def initialize(user)
    @user = user
    @tweeted = []
  end

  def scheduled_tweets
    twitter_retry_to do
      tweet_text = load_tweet
      tweet = user.update(tweet_text)
      tweeted << tweet
    end
    tweeted
  end
end
