Dotenv.load

option = {}
OptionParser.new do |opt|
  opt.on('-e [VALUE]', '環境名') { |v| option[:env] = v }
  opt.parse!(ARGV)
end
option[:env] ||= 'development'
OPTS = option.freeze

ar_config = YAML.load_file( './database.yml' )
ActiveRecord::Base.establish_connection(ar_config['db'][OPTS[:env]])
ActiveRecord::Base.default_timezone = :local
Time.zone_default =  Time.find_zone! 'Tokyo'
