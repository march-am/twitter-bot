class Schedule < ActiveRecord::Base
  serialize :time, Tod::TimeOfDay

  scope :just_today, -> { Schedule.where(year: now.year, month: now.month, day: now.day) }
  scope :today, -> { Schedule.where(month: now.month, day: now.day) }

  class << self
    def now
      @@now ||= Time.zone.now
    end

    # 指定時間のEXEC_INTERVAL秒内 && last_tweeted_at から1時間以上経っているtweetをselect
    def nearly_now
      now_tod = Tod::TimeOfDay(now)
      end_tod = now_tod + EXEC_INTERVAL
      start_tod = now_tod - EXEC_INTERVAL
      # FIXME: RelationじゃなくてArrayにしちゃうのでなんとかしたい
      select do |tweet|
        Tod::Shift.new(start_tod, end_tod).include?(tweet.time) \
        && (tweet.last_tweeted_at + 60 * 60 < now)
      end
    end
  end
end
