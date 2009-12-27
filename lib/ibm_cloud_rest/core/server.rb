module IbmCloudRest
  class Server
    attr_accessor :uri, :uuid_batch_count, :available_instances
    def initialize(server = 'https://www.ibm.com', base_path= '/cloud/developer/api/rest/20090403', uuid_batch_count = 1000)
      @uri = server+base_path
      @uuid_batch_count = uuid_batch_count
    end
  
    # Lists all "available" instances.
    # An available instance, is a instance that was specified
    # as avaiable by your code.
    # It allows to define common instances to use and reuse in your code
    def available_instances
      @available_instances ||= {}
    end
    
    # Adds a new available instance and create it unless it already exists
    #
    # Example:
    #
    # @couch = IbmCloudRest::Server.new
    # @couch.define_available_instance(:default, "tech-blog")
    #
    def define_available_instance(reference, db_name, create_unless_exists = true)
      available_instances[reference.to_sym] = create_unless_exists ? instance!(db_name) : instance(db_name)
    end
  
    # Checks that a instance is set as available
    #
    # Example:
    #
    # @couch.available_instance?(:default)
    #
    def available_instance?(ref_or_name)
      ref_or_name.is_a?(Symbol) ? available_instances.keys.include?(ref_or_name) : available_instances.values.map{|db| db.name}.include?(ref_or_name)
    end
  
    def default_instance=(name, create_unless_exists = true)
      define_available_instance(:default, name, create_unless_exists = true)
    end
    
    def default_instance
      available_instances[:default]
    end
  
    # Lists all instances on the server
    def instances
      IbmCloudRest.get "#{@uri}/instances"
    end
  
    # Returns a IbmCloudRest::instance for the given name
    def instance(name)
      IbmCloudRest::instance.new(self, name)
    end
  
    # Creates the instance if it doesn't exist
    def instance!(name)
      create_db(name) rescue nil
      instance(name)
    end
  
    # GET the welcome message
    def info
      IbmCloudRest.get "#{@uri}/"
    end

    # Create a instance
    def create_db(name)
      IbmCloudRest.put "#{@uri}/#{name}"
      instance(name)
    end

    # Restart the CouchDB instance
    def restart!
      IbmCloudRest.post "#{@uri}/_restart"
    end

    # Retrive an unused UUID from CouchDB. Server instances manage caching a list of unused UUIDs.
    def next_uuid(count = @uuid_batch_count)
      @uuids ||= []
      if @uuids.empty?
        @uuids = IbmCloudRest.get("#{@uri}/_uuids?count=#{count}")["uuids"]
      end
      @uuids.pop
    end

  end
end
