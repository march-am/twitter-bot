class RelationshipMaganer
  include Retry

  def initialize(user)
    @user = user
  end

  def refollow_all
    followed = []
    twitter_retry do
      @user.followers.each do |follower|
        unless @user.friends.include?(follower)
          unless @user.friendships_outgoing.include?(follower)
            @user.follow(follower)
            followed  << follower
          end
        end
      end
    end
    followed
  end

  # 相手がもうフォローしていなければこちらもアンフォロー
  def unfollow_onesided
    unfollowed = []
    twitter_retry do
      @user.friends.each do |friend|
        unless @user.followers.include?(friend)
          @user.unfollow(friend)
          unfollowed << friend
        end
      end
    end
    unfollowed
  end
end
