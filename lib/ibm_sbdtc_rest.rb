# Copyright 2010 David Ruan
# 
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
# 
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'rubygems'
begin
  require 'json'
rescue LoadError
  raise "You need install and require your own json compatible library since IbmCloudRest rest couldn't load the json/json_pure gem" unless Kernel.const_defined?("JSON")
end
require 'rest_client'

$:.unshift File.dirname(__FILE__) unless
  $:.include?(File.dirname(__FILE__)) ||
  $:.include?(File.expand_path(File.dirname(__FILE__)))
    
require 'ibm_cloud_rest/monkeypatches'

module IbmCloudRest
  VERSION    = '0.0.0' unless self.const_defined?("VERSION")
  
  autoload :Server,       'ibm_cloud_rest/core/server'
  autoload :Image,       'ibm_cloud_rest/core/image'
  autoload :Instance,       'ibm_cloud_rest/core/instance'
  autoload :Storage,       'ibm_cloud_rest/core/storage'
  autoload :Address,       'ibm_cloud_rest/core/address'
  autoload :Key,       'ibm_cloud_rest/core/key'
  autoload :Request,       'ibm_cloud_rest/core/request'
  
  
  require File.join(File.dirname(__FILE__), 'ibm_cloud_rest', 'core', 'rest_api')
  require File.join(File.dirname(__FILE__), 'ibm_cloud_rest', 'core', 'http_abstraction')
  require File.join(File.dirname(__FILE__), 'ibm_cloud_rest', 'mixins')

  # we extend IbmCloudRest with the RestAPI module which gives us acess to
  # the get, post, put, delete and copy
  IbmCloudRest.extend(::RestAPI)
  
  # The IbmCloudRest module methods handle the basic JSON serialization 
  # and deserialization, as well as query parameters. The module also includes
  # some helpers for tasks like instantiating a new Database or Server instance.
  class << self

    # extracted from Extlib
    #
    # Constantize tries to find a declared constant with the name specified
    # in the string. It raises a NameError when the name is not in CamelCase
    # or is not initialized.
    #
    # @example
    # "Module".constantize #=> Module
    # "Class".constantize #=> Class
    def constantize(camel_cased_word)
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ camel_cased_word
        raise NameError, "#{camel_cased_word.inspect} is not a valid constant name!"
      end

      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end
    
    # extracted from Extlib
    #    
    # Capitalizes the first word and turns underscores into spaces and strips _id.
    # Like titleize, this is meant for creating pretty output.
    #
    # @example
    #   "employee_salary" #=> "Employee salary"
    #   "author_id" #=> "Author"
    def humanize(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize
    end
    
    # todo, make this parse the url and instantiate a Server or Database instance
    # depending on the specificity.
    def new(*opts)
      Server.new(*opts)
    end
    
    def parse url
		  base_path_pattern=/\/cloud\/developer\/api\/rest\/\d+/
      case url
      when /(^https:\/\/.*)(#{base_path_pattern})\/(.*)\/(.*)/
        host = $1
				bash_path = $2
        object = $3
        docid = $4
      when /(^https:\/\/.*)(#{base_path_pattern})\/(.*)/
        host = $1
				bash_path = $2
        object = $3
      when /(^https:\/\/.*)/
        host = $1
      when /(.*)(#{base_path_pattern})\/(.*)\/(.*)/
        host = $1
				bash_path = $2
        object = $3
        docid = $4
      when /(.*)(#{base_path_pattern})\/(.*)/
        host = $1
				bash_path = $2
        object = $3
      else
        object = url
      end

      object = nil if object && object.empty?
      # https://www.ibm.com/cloud/developer/api/rest/20090403/
      {
        :host => host || "https://www.ibm.com",
				:base_path=> base_path || "/cloud/developer/api/rest/20090403",
        :object => object,
        :doc => docid
      }
    end

    # set proxy to use
    def proxy url
      HttpAbstraction.proxy = url
    end

    def instances url
      parsed = parse url
      cr = IbmCloudRest.new(parsed[:host],parsed[:base_path])
      cr.instances
    end
 
    # ensure that a database exists
    # creates it if it isn't already there
    # returns it after it's been created
    def database! url
      parsed = parse url
      cr = IbmCloudRest.new(parsed[:host],parsed[:base_path])
      cr.database!(parsed[:database])
    end
  
    def database url
      parsed = parse url
      cr = IbmCloudRest.new(parsed[:host],parsed[:base_path])
      cr.database(parsed[:database])
    end
    
    def paramify_url url, params = {}
      if params && !params.empty?
        query = params.collect do |k,v|
          v = v.to_json if %w{key startkey endkey}.include?(k.to_s)
          "#{k}=#{CGI.escape(v.to_s)}"
        end.join("&")
        url = "#{url}?#{query}"
      end
      url
    end
  end # class << self
end
