module IbmCloudRest
  class Storage
    STATES=%w[NEW
              CREATING
              DELETING
              DELETED
              UNMOUNTED
              MOUNTED
              FAILED
             ]
    attr_accessor :uri
    def initialize(server = 'https://www.ibm.com', base_path= '/cloud/developer/api/rest/20090403/storage/', uuid_batch_count = 1000)
      @uri = server+base_path
    end
		def get(id)
      IbmCloudRest.get @uri+id.to_s
		end
	end
end
