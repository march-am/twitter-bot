require 'spec_helper'

describe Schedule do
  let(:scheduled) { create(:schedule) }

  describe 'scope :nearly_at' do
    it 'returns tweets scheduled to post within EXEC_INTERVAL_SEC diff' do
      within = Schedule.nearly_at(scheduled.time - EXEC_INTERVAL_SEC).first
      expect(within.id).to eq scheduled.id
    end

    it 'returns no tweets over EXEC_INTERVAL_SEC diff' do
      over = Schedule.nearly_at(scheduled.time + EXEC_INTERVAL_SEC + 60).first
      expect(over).to be_nil
    end
  end

  describe 'scope :today' do
    it 'returns tweets scheduled to post with the same date' do
      tweet_set_today = create(:scheduled_today, year: (Date.today - 2.year))
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
