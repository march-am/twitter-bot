class TweetManager
  include Retry
  attr_reader :user, :tweeted

  def initialize(user)
    @user = user.client
    @tweeted = []
  end

  def tweet_scheduled
    to_tweet = load_tweet
    return unless to_tweet
    twitter_retry_to do
      now_tweeted = user.update(to_tweet.content)
      to_tweet.update(last_tweeted_at: now)
      tweeted << now_tweeted
    end
    tweeted
  end

  def load_tweet
    Schedule.nearly_at(now).sample
  end

  private

    def now
      @now ||= Time.zone.now
    end
end
