FactoryBot.define do
  factory :schedule do
    year  nil
    month 1
    day   1
    time  '12:00'
    content '[過去記事] 2017-01-01: TEST ARTICLE https://path.to/article/page.html'
    memo 'memo'
    last_tweeted_at Time.parse('2017-01-01T12:01')
  end

  factory :scheduled_today, class: Schedule do
    year  Date.today.year
    month Date.today.month
    day   Date.today.day
    time  Time.now
    content '[過去記事] 2017-01-01: TEST ARTICLE https://path.to/article/page.html'
    memo 'memo'
    last_tweeted_at Time.now - 1.day
  end
end
