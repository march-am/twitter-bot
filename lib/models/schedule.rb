class Schedule < ActiveRecord::Base
  serialize :time, Tod::TimeOfDay

  scope :just_today, -> { where(year: now.year, month: now.month, day: now.day) }
  scope :today, -> { where(month: now.month, day: now.day) }

  class << self
    # 指定時間のEXEC_INTERVAL秒内 && last_tweeted_at から1時間以上経っているtweetをselect
    def nearly_at(time)
      time = Tod::TimeOfDay(time) if time.is_a? Time
      end_tod   = time + EXEC_INTERVAL_SEC
      start_tod = time - EXEC_INTERVAL_SEC
      # FIXME: RelationじゃなくてArrayにしちゃうのでなんとかしたい
      select do |tweet|
        Tod::Shift.new(start_tod, end_tod).include?(tweet.time) \
        && (tweet.last_tweeted_at + 60 * 60 < now)
      end
    end

    def now
      Time.zone.now
    end
  end
end
