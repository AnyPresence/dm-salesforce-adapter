namespace :salesforce do
  desc "Generate SOAP classes.  wsdl_path is the path to your WSDL file, and api_dir is the folder to which generated classes will be written"
  task :generate_soap_classes, :wsdl_path, :api_dir do |t, args|
    wsdl_path = args[:wsdl_path]
    api_dir = args[:api_dir]
    if wsdl_path.nil? or api_dir.nil?
      raise "Aborting: wsdl_path and api_dir parameters must be provided" 
    else
      require 'dm-salesforce-adapter'
      path = File.join(api_dir, File.basename(wsdl_path))
      FileUtils.rm_rf path
      wrapper = ::SalesforceAdapter::SoapWrapper.new("SalesforceAPI", "Soap", wsdl_path, api_dir, force_regeneration: true)
    end
  end
end
