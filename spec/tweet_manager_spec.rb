require 'spec_helper'

describe TweetManager do
  let(:manager) { TweetManager.new(mock_user) }

  describe '#tweet_scheduled' do
    it 'posts a tweet to do' do
      scheduled = create(:schedule)
      checked_at = Time.new('2018-01-01T12:00:00')
      manager.instance_variable_set(:@now, checked_at)
      binding.pry
      manager.tweet_scheduled
    end
  end

  describe '#load_tweet' do
    it 'returns one tweet which scheduled to post nearly now' do
      to_tweet = manager.load_tweet
      if Schedule.all.size.zero?
        expect(to_tweet).to eq(nil)
      else
        expect(to_tweet.size).to eq(1)
      end
    end
  end

  def mock_user
    mock_user = double('Twitter user')
    mock_client = double('Twitter client')
    allow(mock_user).to receive(:client).and_return(mock_client)
    allow(mock_client).to receive(:update).and_return('tweet text')
    mock_user
  end
end
