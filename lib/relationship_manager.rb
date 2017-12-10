class RelationshipMaganer
  include Retry
  attr_reader :user, :followed, :unfollowed

  def initialize(user)
    @user = user
    @followed = []
    @unfollowed = []
  end

  def refollow_all
    twitter_retry_to do
      user.followers.each do |follower|
        unless user.friends.include?(follower)
          unless user.friendships_outgoing.include?(follower)
            user.follow(follower)
            followed  << follower
          end
        end
      end
    end
    followed
  end

  # 相手がもうフォローしていなければこちらもアンフォロー
  def unfollow_onesided
    twitter_retry_to do
      user.friends.each do |friend|
        unless user.followers.include?(friend)
          user.unfollow(friend)
          unfollowed << friend
        end
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
