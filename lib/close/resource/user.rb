module Close
    class User < APIResource

      def self.resource_url
        'api/v1/user/'
      end

      def self.me
        new({}, request(:get, "#{resource_url}me/"))
      end

      def self.availability(params={})
        items = request(:get, "#{resource_url}availability/", params)
        items['data'].map { |item| new({}, item) }
      end

    end
end