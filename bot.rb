require 'twitter'
require 'csv'
require 'retryable'
require 'optparse'
require 'active_record'

require './lib/common/setup'
if OPTS[:env] == 'development'
  require 'pry'
  require 'dotenv'
end

require './lib/common/retry'
require './lib/models/schedules'
require './lib/models/random'
require './lib/models/reply'
require './lib/relationship_manager'
require './lib/schedule_runner'
require './lib/tweet_manager'
require './lib/twitter_user'

=begin

# 仕様

- cronで10分に1回実行
- DBを読み込み、実行した状況に合わせてツイートやフォロー管理をする
- 結果を標準出力し、cronでloggingする

TODO:
- CL引数で必要な処理（フォロー/ツイート）だけを実行できるようにする
- CL引数に合わせて必要なモジュールだけrequireして読み込みを軽くする

=end

runner = ScheduleRunner.new
runner.run
