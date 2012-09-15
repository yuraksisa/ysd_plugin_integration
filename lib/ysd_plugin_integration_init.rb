require 'ysd-plugins' unless defined?Plugins::Plugin
require 'sinatra/ysd_sinatra_integration'
require 'ysd_plugin_integration_extension'

Plugins::SinatraAppPlugin.register :integration do

   name=        'integration'
   author=      'yurak sisa'
   description= 'Integrate the integration external services application'
   version=     '0.1'
   sinatra_extension Sinatra::YSD::Integration
   sinatra_extension Sinatra::YSD::ExternalServiceAccountManagement
   sinatra_extension Sinatra::YSD::ExternalServiceAccountManagementRESTApi
   hooker            Huasi::IntegrationExtension
  
end