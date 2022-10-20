# frozen_string_literal: true

require 'simplecov'
require 'simplecov_json_formatter'
SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start

require "close"
require "support/fake_close"
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  Close.configure do |config|
    config.api_key = "test"
    config.logger = nil
  end

  # Dsl for stubbing requests.
  config.before(:each) do
    stub_request(:any, /api.close.com/).to_rack(FakeClose::Base)
  end

end
