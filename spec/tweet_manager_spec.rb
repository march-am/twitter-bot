require 'spec_helper'

describe TweetManager do
  let(:mock_user) { MockUser.new }
  let(:manager) { TweetManager.new(mock_user) }

  describe '#tweet_scheduled' do
    it 'posts a tweet to do' do
      true
    end
  end

  describe '#load_tweet' do
    it 'returns nearly now tweets' do
      to_tweet = manager.load_tweet
      if Schedule.all.size.zero?
        expect(to_tweet).to eq(nil)
      else
        expect(to_tweet.size).to eq(1)
      end
    end
  end
end

class MockUser
  def client
    MockClient.new
  end
end

class MockClient
  def update(text)
    text
  end
end
