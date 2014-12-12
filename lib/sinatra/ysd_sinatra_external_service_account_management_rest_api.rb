require 'ysd_md_integration' unless defined?ExternalIntegration
require 'uri' unless defined?URI

module Sinatra
  module YSD
    #
    # REST API for ExternalIntegration::ExternalServiceAccount
    #
    module ExternalServiceAccountManagementRESTApi
   
      def self.registered(app)
        
        #
        # Retrive all external service accounts (GET)
        #
        app.get "/api/external-service-accounts" do
          
          data=ExternalIntegration::ExternalServiceAccount.all
  
          content_type :json
          data.to_json
        end
        
        #
        # Retrieve external service accounts (POST)
        #
        ["/api/external-service-accounts","/api/external-service-accounts/page/:page"].each do |path|
          app.post path do
          
            data=ExternalIntegration::ExternalServiceAccount.all
            
            begin # Count does not work for all adapters
              total=ExternalIntegration::ExternalServiceAccount.count
            rescue
              total=ExternalIntegration::ExternalServiceAccount.all.length
            end
            
            content_type :json
            {:data => data, :summary => {:total => total}}.to_json
          
          end
        
        end
        
        #
        # Create a new external service accounts
        #
        app.post "/api/external-service-account" do
          
          request.body.rewind
          account_request = JSON.parse(URI.unescape(request.body.read))
          
          the_account = ExternalIntegration::ExternalServiceAccount.create(account_request) 
          
          status 200
          content_type :json
          the_account.to_json          
        
        end
        
        #
        # Updates a external service account
        #
        app.put "/api/external-service-account" do
        
          request.body.rewind
          account_request = JSON.parse(URI.unescape(request.body.read))
          
          the_account = ExternalIntegration::ExternalServiceAccount.get(account_request['id'])
          the_account.attributes=(account_request)
          the_account.save
                             
          # Return          
          status 200
          content_type :json
          the_account.to_json
        
        end
        
        #
        # Deletes a external service account
        #
        app.delete "/api/external-service-account" do
        
        end
      
      end
    
    end #ExternalServiceAccountManagementRESTApi
  end #YSD
end #Sinatra