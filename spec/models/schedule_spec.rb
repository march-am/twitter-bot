require 'spec_helper'

describe Schedule do
  describe 'scope :nearly_at' do
    let(:scheduled) { create(:schedule) }

    it 'returns tweets scheduled to post within EXEC_INTERVAL_SEC diff' do
      within = Schedule.nearly_at(scheduled.time - EXEC_INTERVAL_SEC).first
      expect(within.id).to eq scheduled.id
    end

    it 'returns no tweets over EXEC_INTERVAL_SEC diff' do
      over = Schedule.nearly_at(scheduled.time + EXEC_INTERVAL_SEC + 60).first
      expect(over).to be_nil
    end

    it 'returns certain tweets with last_tweeted_at: nil' do
      prev_untweeted = create(:schedule, last_tweeted_at: nil)
      to_tweet = Schedule.nearly_at(prev_untweeted.time).first
      expect(to_tweet.id).to eq prev_untweeted.id
    end

    it 'returns no tweets with last_tweeted_at: nil and different date' do
      prev_untweeted_not_to_tweet = create(:schedule, day: (Date.today - 1.day).day, last_tweeted_at: nil)
      to_tweet = Schedule.nearly_at(prev_untweeted_not_to_tweet.time).first
      expect(to_tweet).not_to eq prev_untweeted_not_to_tweet.id
    end
  end

  describe 'scope :today' do
    it 'returns tweets scheduled to post with the same date' do
      tweet_set_today = create(:scheduled_today, year: (Date.today - 2.year).year)
      today = Schedule.today.first
      expect(today.id).to eq tweet_set_today.id
    end
  end

  describe 'scope :just_today' do
    it 'returns tweets scheduled to post with the same year & date' do
      tweet_set_today = create(:scheduled_today)
      today = Schedule.just_today.first
      expect(today.id).to eq tweet_set_today.id
    end
  end
end
