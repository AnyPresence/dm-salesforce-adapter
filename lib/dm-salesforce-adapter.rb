require 'data_objects'
require 'dm-core'
require 'dm-types'
require 'dm-validations'

require 'soap/wsdlDriver'
require 'soap/header/simplehandler'
require 'rexml/element'

class SalesforceAdapter < ::DataMapper::Adapters::AbstractAdapter
  Inflector = ::DataMapper::Inflector
end

module DataMapper
  module Adapters    
    ::DataMapper::Adapters::SalesforceAdapter = SalesforceAdapter
    self.send(:const_added, :SalesforceAdapter)
  end  
end

require 'dm-salesforce-adapter/resource'
require 'dm-salesforce-adapter/connection'
require 'dm-salesforce-adapter/connection/errors'
require 'dm-salesforce-adapter/soap_wrapper'
require 'dm-salesforce-adapter/sql'
require 'dm-salesforce-adapter/version'
require 'dm-salesforce-adapter/adapter'
require 'dm-salesforce-adapter/property'
require 'dm-salesforce-adapter/blank' unless Object.method_defined?(:blank?)

# For convenience (WRT the examples)
module DataMapper::Salesforce
    Resource = ::DataMapper::Adapters::SalesforceAdapter::Resource
end

