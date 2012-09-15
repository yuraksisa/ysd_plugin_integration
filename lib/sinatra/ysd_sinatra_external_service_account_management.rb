module Sinatra
  module YSD
    module ExternalServiceAccountManagement
   
      def self.registered(app)
        
        #
        # External service accounts management page
        #
        app.get "/external-service-account-management" do
          load_page 'external_service_account_management'.to_sym
        end
        
      end
    
    end #ExternalServiceAccountManagement
  end #YSD
end #Sinatra