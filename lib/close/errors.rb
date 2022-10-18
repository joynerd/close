module Close
  class RateLimitExceeded < StandardError; end
  class InvalidRequestError < StandardError; end
  class AuthenticationError < StandardError; end
  class APIError < StandardError; end
end