require 'spec_helper'

describe TweetManager do
  let(:manager) { TweetManager.new(mock_user) }

  describe '#tweet_scheduled' do
    it 'posts a tweet obtained from #load_tweet' do
      scheduled = create(:scheduled_today)
      # load_tweetの実装に関わりなくテスト
      allow(manager).to receive(:load_tweet).and_return(scheduled)
      tweeted = manager.tweet_scheduled.first
      expect(tweeted).to eq scheduled.content
    end
  end

  describe '#load_tweet' do
    it 'returns one tweet which scheduled to post nearly now' do
      will_tweet_soon = create(:scheduled_today)
      to_tweet = manager.load_tweet
      expect(to_tweet.id).to eq will_tweet_soon.id
    end
  end

  def mock_user
    mock_user = double('Twitter user')
    mock_client = Class.new do
      def self.update(content)
        content
      end
    end
    allow(mock_user).to receive(:client).and_return(mock_client)
    mock_user
  end
end
