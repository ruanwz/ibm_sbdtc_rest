module IbmCloudRest
  class Key
    attr_accessor :uri
    def initialize(server = 'https://www.ibm.com', base_path= '/cloud/developer/api/rest/20090403/keys/', uuid_batch_count = 1000)
      @uri = server+base_path
    end
		def get(id)
      IbmCloudRest.get @uri+id.to_s
		end
	end
end
