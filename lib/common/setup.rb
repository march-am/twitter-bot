option = {}
option[:env] ||= ENV['APP_ENV'] || 'development'
OPTS = option.freeze

ar_config = YAML.load_file('./database.yml')
ActiveRecord::Base.establish_connection(ar_config[OPTS[:env]])
ActiveRecord::Base.default_timezone = :local
Time.zone_default = Time.find_zone! 'Tokyo'
