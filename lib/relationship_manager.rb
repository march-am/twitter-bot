class RelationshipManager
  include Retry
  attr_reader :user, :followed, :unfollowed

  def initialize(user)
    @user = user.client
    @followed = []
    @unfollowed = []
  end

  def refollow_all
    twitter_retry_to do
      user.followers.each do |follower|
        next if user.friends.include?(follower)
        next if user.friendships_outgoing.include?(follower)
        user.follow(follower)
        followed  << follower
      end
    end
    followed
  end

  # 相手がもうフォローしていなければこちらもアンフォロー
  def unfollow_onesided
    twitter_retry_to do
      user.friends.each do |friend|
        next if user.followers.include?(friend)
        user.unfollow(friend)
        unfollowed << friend
      end
    end
    unfollowed
  end

  def any_followed?
    followed.present?
  end

  def any_unfollowed?
    unfollowed.present?
  end
end
