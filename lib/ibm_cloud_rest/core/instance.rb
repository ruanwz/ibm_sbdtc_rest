module IbmCloudRest
  class Instance
    STATUS=%w[NEW
              PROVISIONING
              FAILED
              REMOVED
              REJECTED
              ACTIVE
              UNKNOWN
              DEPROVISIONING
              RESTARTING
              STARTING
              STOPPING
              STOPPED
            ]
    attr_accessor :uri, :uuid_batch_count, :available_instances
    def initialize(server = 'https://www.ibm.com', base_path= '/cloud/developer/api/rest/20090403/instances/', uuid_batch_count = 1000)
      @uri = server+base_path
      @uuid_batch_count = uuid_batch_count
    end
		def get(id)
      IbmCloudRest.get @uri+id.to_s
		end
	end
end
