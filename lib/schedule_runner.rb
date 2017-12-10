class ScheduleRunner
  attr_reader :to_do

  def initialize
    @todo = []
  end

  def todo_builder
    now = Time.now
    # nowのdatetimeをみて、やることをくみたてる
    # @todo ||= に追加する
  end

  def run
    user        = TwitterUser.new
    friends_mng = RelationshipManager.new(user)
    tweet_mng   = TweetMaganer.new(user)

    followed    = friends_mng.refollow_all
    # unfollowed  = follow_mng.unfollow_onesided
    tweeted     = tweet_mng.scheduled_tweets

    ### output ###

    puts "at #{Time.now.to_s}"
    if followed
      puts 'Followed:'
      p followed.map { |f| "#{f.name} (#{f.screen_name})" }.join(', ')
    elsif unfollowed
      puts 'Unfollowed:'
      p unfollowed.map { |f| "#{f.name} (#{f.screen_name})" }.join(', ')
    elsif tweeted
      puts 'Tweeted:'
      p tweeted.map { |f| "#{f.text} (#{f.created_at})"}.join(', ')
    else
      # puts 'did nothing'
    end
  end
end
