module Sinatra
  module YSD
    module ExternalServiceAccountManagement
   
      def self.registered(app)
        
        #
        # External service accounts management page
        #
        app.get "/admin/external-service-accounts" do
          load_page :external_service_account_management
        end
        
      end
    
    end #ExternalServiceAccountManagement
  end #YSD
end #Sinatra