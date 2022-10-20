# This class attempts to abstract away the Advanced Filter API.
# It is very powerful and fast, but building the queries is very tedious.
# It allows to store preset queries as JSON for common queries that
# can be commited to the repo and validated. It also lets you
# define queries on the fly which can then be reused across the 
# codebase without having to copy and paste the query all the time.
module Close
  class Filter
    extend APIOperations

    @@queries = {}

    # Executes a raw query against the Close API.
    # @param [Hash] query The query to execute.
    # @return [Array] An array of results.
    def self.execute(query = {})
      response = request(:post, 'api/v1/data/search/', query)
      response['data']
    end

    # Executes a query by name.
    # @param [String] name The name of the query to execute.
    # @param [Hash] params The parameters to pass to the query.
    # @return [Array] An array of results.
    def self.run(name, params = {})
      query_string = load_query_from_file(name)
      expected_params = find_params(query_string)
      preflight_params(params, expected_params)
      parameterized_query = apply_params(query_string, params)
      execute(parameterized_query)
    end

    # Loads a query from a file or from memory.
    # @param [String] name The name of the query.
    # @return [String] A stringified JSON query.
    def self.load_query(name)
      if @@queries[name.to_s]
        @@queries[name.to_s]
      else
        load_query_from_file(name)
      end
    end

    # This method is used to defined a query at run time.
    # If a name collision occurs, the query will be overwritten.
    # @param [String] name The name of the query.
    # @param [Hash] query_body A hash with placeholders in keys.
    # @return [Void]
    def self.add_query(name, query_body)
      @@queries[name.to_s] = query_body.to_json
    end

    # Applies the params to the query string.
    # @param [String] query_string The stringified JSON query.
    # @param [Hash] params The parameters to apply.
    # @return [String] The stringified JSON query with the parameters applied.
    def self.apply_params(query_string, params)
      qs = query_string.dup
      params.each do |key, value|
        qs.gsub!(/%#{key.upcase}%/, value)
      end
      qs
    end

    # Check that all of the params are present in expected_params.
    # @param [Hash] params The parameters to check.
    # @param [Array] expected_params The expected parameters.
    # @return [Void]
    # @raise [Close::MissingParameterError] if a parameter is missing.
    def self.preflight_params(params, expected_params)
      expected_params.each do |param|
        if !params.transform_keys(&:to_s).has_key?(param.to_s)
          raise Close::MissingParameterError, "Missing parameter: #{param}"
        end
      end
    end

    # Loads a predefined query from a file.
    # @param [String] name The name of the query.
    # @return [String] A stringified JSON query.
    # @raise [Close::QueryNotFoundError] if the file does not exist.
    def self.load_query_from_file(name)
      begin
        file = File.read(File.join(File.dirname(__FILE__), "data/filters/#{name}.json"))
        #file = File.read(File.expand_path("lib/close/data/filters/#{name}.json", __dir__))
      rescue Errno::ENOENT
        raise Close::QueryNotFoundError.new("Query #{name} not found.")
      end
    end

    # Scans a string a returns the parameters it will expect
    # when executed.
    # @param [String] str The string to scan.
    # @return [Array] An array of parameters.
    def self.find_params(str)
      str.scan(/%[A-Z]+(?:_[A-Z]+)*%/).map{ |x| x[1..-2].downcase }.uniq
    end

  end
end
