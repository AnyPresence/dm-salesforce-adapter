require 'spec/spec_helper'

module DataMapper::Salesforce
  describe "Using the raw connection" do
    
    before(:all) do
      raise "Expected configuration file database.yml to be present!  Please configure datamapper in config/database.yml" unless File.exists? 'config/database.yml'
      
      database_yaml = YAML.load_file('config/database.yml')
      @username = database_yaml['development']['repositories']['salesforce']['username']
      @password = database_yaml['development']['repositories']['salesforce']['password']
    end
    
    describe "when authenticating without an organization id" do
      describe "with the correct credentials" do
        it "succeeds" do
          db = ::DataMapper.repository(:salesforce).adapter.connection
          ::SalesforceAdapter::Connection.new(@username, @password, db.wsdl_path, db.api_dir)
        end
      end

      describe "with an invalid password" do
        it "fails to login" do
          db = ::DataMapper.repository(:salesforce).adapter.connection
          lambda { ::SalesforceAdapter::Connection.new(@username, 'bad-password', db.wsdl_path, db.api_dir) }.
            should raise_error(::SalesforceAdapter::Connection::LoginFailed)
        end
      end
    end

    describe "when authenticating with an organization id" do
      describe "with the correct self service credentials" do
        it "succeeds" do
          pending "self service is no longer supported"
          db = DataMapper.repository(:salesforce).adapter.connection
          Connection.new(VALID_SELF_SERVICE_USER.username, VALID_SELF_SERVICE_USER.password, db.wsdl_path, db.api_dir, db.organization_id)
        end
      end

      describe "with an invalid password" do
        it "fails to login" do
          pending "self service is no longer supported"
          db = DataMapper.repository(:salesforce).adapter.connection
          lambda { Connection.new(VALID_SELF_SERVICE_USER.username, "bad-password", db.wsdl_path, db.api_dir, db.organization_id) }.
            should raise_error(Connection::LoginFailed)
        end
      end
    end
  end
end
