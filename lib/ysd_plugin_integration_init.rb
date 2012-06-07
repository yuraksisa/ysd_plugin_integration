require 'ysd-plugins' unless defined?Plugins::Plugin
require 'ysd_plugin_integration_middleware'
require 'ysd_plugin_integration_extension'

Plugins::SinatraAppPlugin.register :integration do

   name=        'integration'
   author=      'yurak sisa'
   description= 'Integrate the integration external services application'
   version=     '0.1'
   sinatra_extension Sinatra::Integration
   sinatra_extension Sinatra::YSD::ExternalServiceAccountManagement
   hooker            Huasi::IntegrationExtension
  
end