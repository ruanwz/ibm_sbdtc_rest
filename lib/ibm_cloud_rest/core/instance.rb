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
		def restart(id)
			doc={"state"=>"restart"}
      IbmCloudRest.put(@uri+id.to_s, 'state=restart')
		end
		def save(id)
      IbmCloudRest.put(@uri+id.to_s, "state: save\nname: saved_image\ndescription: saved at #{Time.now}")
		end

	end
end
