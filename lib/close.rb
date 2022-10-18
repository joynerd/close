# frozen_string_literal: true
require "ostruct"
require "faraday"

require_relative "close/close_object"
require_relative "close/api_operations"
require_relative "close/api_resource"
require_relative "close/resources"
require_relative "close/errors"
require_relative "close/version"

module Close
  class Error < StandardError; end
  
  # The default configuration object.
  # @option api_key [String] The API key to use for requests.
  # @option rate_limit_behavior [Symbol] :raise_error, :retry, TODO: :proactive.
  # @option logger [Logger] Where, if any, to log requests.
  def self.configuration
    @@configuration ||= OpenStruct.new({
      api_key: ENV['CLOSE_API_KEY'],
      rate_limit: :raise_error,
      logger: Logger.new(STDOUT),
    })
  end

  # Allow block setting of configuration options.
  def self.configure
    yield(configuration)
  end

end
