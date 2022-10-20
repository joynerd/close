# Fake close is a really dumb representation of the Close API. It's used for testing purposes only.
# It doesn't do any logic or data validation of a request. It just serves up JSON responses that
# should match the Close API. It's not meant to be a full representation of the API, just enough
# to test the gem.

require 'sinatra/base'

module FakeClose
  class Base < Sinatra::Base

    #
    # Advanced Filters
    #

    post '/api/v1/data/search/' do
      json_response 200, 'advanced_filters.json'
    end

    #
    # Activities
    #

    get '/api/v1/activity/' do
      json_response 200, 'advanced_filters.json'
    end

    #
    # Custom Activity Types
    #

    get '/api/v1/custom_activity/' do
      json_response 200, 'custom_activity_types.json'
    end

    #
    # Leads
    #

    get '/api/v1/lead/' do
      json_response 200, 'leads.json'
    end

    private

    def json_response(response_code, file_name)
      content_type :json
      status response_code
      File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
    end
    
  end
end