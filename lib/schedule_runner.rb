class ScheduleRunner
  attr_reader :to_do

  def initialize
    @todo = []
  end

  # nowのdatetimeをみて、やることをくみたてる
  # @todo ||= に追加する
  # def todo_builder
  #   now = Time.now
  # end

  def run
    user        = TwitterUser.new
    friends_mng = RelationshipManager.new(user)
    tweet_mng   = TweetManager.new(user)
    # followed    = friends_mng.refollow_all
    # unfollowed  = follow_mng.unfollow_onesided
    tweeted     = tweet_mng.tweet_scheduled

    ### output ###

    if friends_mng.any_followed?
      puts "Followed (at #{Time.now}): "
      puts followed.map { |f| "#{f.name} (#{f.screen_name})" }.join(', ')
    end

    if friends_mng.any_unfollowed?
      puts "Unfollowed (at #{Time.now}): "
      puts unfollowed.map { |f| "#{f.name} (#{f.screen_name})" }.join(', ')
    end

    if tweeted.present?
      puts "Tweeted: (at #{Time.now}): "
      puts tweeted.map { |f| "#{f.text} (#{f.created_at})" }.join(', ')
    end

    # puts 'did nothing'
  end
end
