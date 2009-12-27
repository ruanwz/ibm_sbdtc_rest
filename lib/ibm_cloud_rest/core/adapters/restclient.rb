module RestClientAdapter
   
  module API
		def read_config
			if File.exists? File.expand_path('~/.isbdtcrc')
				return YAML.load(File.new(File.expand_path('~/.isbdtcrc')))
			else
        raise "Error while read config file"
			end
		end
    def proxy=(url)
      RestClient.proxy = url
    end 
    
    def proxy
      RestClient.proxy
    end

    def get(uri, headers={:accept => 'application/json'})
      #RestClient.get(uri, headers)
			config = read_config
			rest_get=RestClient::Request.new(:method => :get, :url => uri, :headers => headers,:user => config['user'], :password => config['password'])
			rest_get.execute
    end
  
    def post(uri, payload, headers={:accept => 'application/json'})
      RestClient.post(uri, payload, headers)
    end
  
    def put(uri, payload, headers={:accept => 'application/json'})
      RestClient.put(uri, payload, headers)
    end
  
    def delete(uri, headers={:accept => 'application/json'})
      RestClient.delete(uri, headers)
    end
  
    def copy(uri, headers)
      RestClient::Request.execute(  :method   => :copy,
                                    :url      => uri,
                                    :headers  => headers) 
    end
  end 
  
end
