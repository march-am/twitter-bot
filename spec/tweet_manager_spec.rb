require 'spec_helper'

describe TweetManager do
  let(:mock_user) { { } }
  let(:instance) { TweetManager.new(mock_user) }

  describe '#tweet_scheduled' do
    it 'posts a tweet to do' do
      # hoge
      true
    end
  end

  describe '#load_tweet' do
    it 'returns nearly now tweets' do
      # hoge
    end
  end
end
