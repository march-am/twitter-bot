module Retry
  def twitter_retry_to
    try_cnt = 0
    begin
      Retryable.retryable(
          tries: 5,
          sleep: 10,
          on: [Twitter::Error],
          not: [Twitter::Error::TooManyRequests]) do |r, e|
        puts "catched \"#{e}\", retry(#{r})"
        yield
      end
    rescue Twitter::Error::TooManyRequests => e
      try_cnt += 1
      puts "catched \"#{e}\", then sleep #{e.rate_limit.reset_in.divmod(60).join('min ')} secs"
      sleep e.rate_limit.reset_in + 1
      retry if try_cnt < 3
    end
  end
end
