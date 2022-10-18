module Close
  class APIResource < CloseObject
    extend APIOperations
    
    # Easy to grok resource name.
    def self.class_name
      name.split('::')[-1]
    end

    # Available subclasses of API resource that can be instanced.
    # Listed from their files in ./resource
    # @return [Array] the available subclasses.
    def self.available_subclasses
      Dir.glob(File.join(File.dirname(__FILE__), 'resource', '*.rb')).map do |file|
        File.basename(file, '.rb').split('_').map(&:capitalize).join
      end
    end

    # Define a resource's URL. We could probably do some magic here
    # to infer the URL from the class name, but it can always be overridden.
    # @return [String] the resource's URL.
    # @raise [NotImplementedError] if the method is not overridden.
    def self.resource_url
      if self == APIResource
        raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Lead, Opportunity, etc.)')
      end
    end
    
    # Retrieves a list of resources.
    # @param opts [Hash] options to pass to the request.
    # @return [Array] an array of resources.
    def self.list(opts = {})
      items = request(:get, resource_url, opts)
      items['data'].map { |item| new({}, item) }
    end

    # Retrieve a singular resource.
    # @param id [String] the resource's ID.
    # @return [Close::APIResource] the resource.
    def self.retrieve(id)
      new({}, request(:get, "#{resource_url}#{id}/"))
    end

    # Creates a resource with the given values.
    # @param values [Hash] the values to create the resource with.
    # @return [Close::APIResource] the created resource.
    def self.create(values = {})
      record = new(values, {})
      record.save
      record
    end

    # Initialize a new resource with the given values.
    # @param values [Hash] the values to initialize the resource with.
    # @param existing_values [Hash] the values that already exist on the server.
    # @return [Close::APIResource] the initialized resource.
    def initialize(values = {}, existing_values = {})
      @values = {}
      @new_values = values
      define_accessors(existing_values)
    end

    # Easily access the mixed existing and new values.
    # @return [Hash] the values.
    def values
      @values.merge(@new_values)
    end

    # Updates the resource on the server. Will not make a request
    # if there are no unsaved changes.
    # @return [Boolean] true if the update succeeded, false otherwise.
    def update
      return true unless dirty?
      resp = self.class.request(:put, "#{self.class.resource_url}#{self.id}/", values)
      @new_values = {}
      @values = resp
      true
    end

    # Persists the values to the server. If the resource already exists,
    # it will update the resource. If the resource does not exist, it will
    # create the resource.
    # @return [Boolean] true if the save succeeded, false otherwise.
    def save
      if defined?(id) && !id.empty?
        update()
      else
        @values = self.class.request(:post, self.class.resource_url, values)
      end
    end

    # Destroy the resource on the server.
    # @return [Boolean] true if the destroy succeeded, false otherwise.
    def destroy
      return false if self.id.empty?
      self.class.request(:delete, "#{self.class.resource_url}#{self.id}/")
      true
    end

    # If there are unsaved/unpersisted changes to the object.
    # @return [Boolean] true if there are unsaved changes, false otherwise.
    def dirty?
      !@new_values.empty?
    end

    # Override the default inspect method to show the object's values.
    # @return [String] the object's values.
    def inspect
      str = "#<#{self.class.name}:#{self.object_id} "
      fields = @values.keys.map{|field| "#{field}: #{self.send(field)}"}
      str << fields.join(", ") << ">"
    end

    private

    # A bunch of magic to define accessors for the resources
    # values. This is to make them behave as existing objects.
    # @param existing_values [Hash] the values to define accessors for.
    def define_accessors(existing_values)
      existing_values.each do |key, value|
        @values[key] = value
        define_singleton_method("#{key}") do
          @new_values[key] || @values[key]
        end
        define_singleton_method("#{key}=") do |value|
          @new_values[key] = value
        end
      end
    end

  end
end