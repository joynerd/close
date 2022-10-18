module Close
  module APIOperations

    def request(method, path, params = {}, opts = {})
      preflight_request(method, path, params, opts)

      case method
      when :get
        response = get(path, params, opts)
      when :post
        response = post(path, params, opts)
      when :put
        response = put(path, params, opts)
      when :delete
        response = delete(path, params, opts)
      end
      
      handle_response(response)
    end

    private

    # Preflight the request to make sure things like caching are handled.
    # TODO: Implement caching.
    # TODO: Implement rate limiting.
    def preflight_request(method, path, params = {}, opts = {})
    end

    # Parse the response from the API and perform error handling.
    # Careful gotcha: The Close API returns a 'data' key for all responses of sets
    # where individual records are just the body.
    def handle_response(response)
      verify_status(response)
      return response.body
    end

    # Check the response status and raise an error if it's not 200.
    # This is where we handle things like rate limiting as well.
    # @param response [Faraday::Response] The response object.
    # @return [Void] 
    # @raise [Close::Error] If the response status is not 200.
    def verify_status(response)
      if response.status == 401
        raise Close::AuthenticationError, response.body
      elsif response.status == 400
        raise Close::InvalidRequestError, response.body
      elsif response.status == 429
        raise Close::RateLimitExceeded, response.body
      elsif response.status == 500
        raise Close::APIError, response.body
      elsif response.status != 200 && response.status != 201 && response.status != 204
        raise Close::APIError, response.body
      end
    end

    def get(path, params = {}, opts = {})
      connection.get(path, params, opts)
    end

    def post(path, params = {}, opts = {})
      connection.post(path, params, opts)
    end

    def put(path, params = {}, opts = {})
      connection.put(path, params, opts)
    end

    def delete(path, params = {}, opts = {})
      connection.delete(path, params, opts)
    end

    # Instance a new Faraday connection.
    # @return [Faraday::Connection] The connection object.
    def connection
      raise Close::AuthenticationError, 'No API key provided.' if Close.configuration.api_key.nil?
      Faraday.new(
        url: 'https://api.close.com',
        headers: {
          accept: 'application/json',
          'User-Agent' => "close-ruby/v#{Close::VERSION}",
        }
      ) do |conn|
        conn.request    :authorization, :basic, Close.configuration.api_key, ''
        conn.request    :json
        conn.response   :json
        conn.response   :logger, Close.configuration.logger if Close.configuration.logger
        conn.adapter    Faraday.default_adapter
      end
    end

  end
end