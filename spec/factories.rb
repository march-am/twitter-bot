FactoryBot.define do
  factory :schedule do
    year 2017
    month 1
    day 1
    time '12:00'
    content '[過去記事] 2017-01-01: TEST ARTICLE https://path.to/article/page.html'
    memo "it's memo"
    last_tweeted_at '2018-01-01T12:01'
  end
end
