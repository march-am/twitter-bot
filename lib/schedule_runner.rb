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
    binding.pry
    user        = TwitterUser.new
    friends_mng = RelationshipManager.new(user)
    tweet_mng   = TweetMaganer.new(user)

    followed    = friends_mng.refollow_all
    # unfollowed  = follow_mng.unfollow_onesided
    tweeted     = tweet_mng.tweet_scheduled

    ### output ###

    puts "at #{Time.now.to_s}"

    if friends_mng.any_followed?
      puts 'Followed:'
      p followed.map { |f| "#{f.name} (#{f.screen_name})" }.join(', ')
    end

    if friends_mng.any_unfollowed?
      puts 'Unfollowed:'
      p unfollowed.map { |f| "#{f.name} (#{f.screen_name})" }.join(', ')
    end

    if tweeted
      puts 'Tweeted:'
      p tweeted.map { |f| "#{f.text} (#{f.created_at})"}.join(', ')
    end

    # puts 'did nothing'
  end
end
