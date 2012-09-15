require 'uri'
require 'ysd_md_integration'
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
        app.get "/external-service-accounts" do
          data=ExternalIntegration::ExternalServiceAccount.all
  
          # Prepare the result
          content_type :json
          data.to_json
        end
        
        #
        # Retrieve external service accounts (POST)
        #
        ["/external-service-accounts","/external-service-accounts/page/:page"].each do |path|
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
        app.post "/external-service-account" do
        
          puts "Creating external service account"
          
          request.body.rewind
          account_request = JSON.parse(URI.unescape(request.body.read))
          
          # Creates the new external service account
          the_account = ExternalIntegration::ExternalServiceAccount.create(account_request) 
          
          puts "created external service account : #{the_account}"
          
          # Return          
          status 200
          content_type :json
          the_account.to_json          
        
        end
        
        #
        # Updates a external service account
        #
        app.put "/external-service-account" do
        
          puts "Updating external service account"
        
          request.body.rewind
          account_request = JSON.parse(URI.unescape(request.body.read))
          
          # Updates the external service account          
          the_account = ExternalIntegration::ExternalServiceAccount.get(account_request['id'])
          the_account.attributes=(account_request)
          the_account.save
          
          puts "updated external service account : #{the_account}"
                   
          # Return          
          status 200
          content_type :json
          the_account.to_json
        
        
        end
        
        #
        # Deletes a external service account
        #
        app.delete "/external-service-account" do
        
        end
      
      end
    
    end #ExternalServiceAccountManagementRESTApi
  end #YSD
end #Sinatra