ENV['APP_ENV'] = 'test'
require './bot.rb'
require 'database_cleaner'
require 'factory_bot'
require 'pry'
Dir[File.join(File.dirname(__FILE__), '..', 'lib', '**/*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '..', 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    FactoryBot.find_definitions
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
