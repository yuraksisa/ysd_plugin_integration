module Sinatra
  module YitoExtension
    #
    # Integration Data REST API
    #
    module IntegrationDataManagementRESTApi

      def self.registered(app)

        #                    
        # Query data integration
        #
        ["/api/integration/data-q","/api/integration/data-q/page/:page"].each do |path|
          
          app.post path, :allowed_usergroups => ['staff'] do

            page = params[:page].to_i || 1
            limit = 20
            offset = (page-1) * 20

            conditions = {}         
            
            if request.media_type == "application/json"
              request.body.rewind
              search_request = JSON.parse(URI.unescape(request.body.read))
              if search_request.has_key?('search') and !search_request['search'].empty?
                conditions = Conditions::JoinComparison.new('$or',
                              [Conditions::Comparison.new(:source_system, '$like', "%#{search_request['search']}%"),
                               Conditions::Comparison.new(:source_entity, '$like', "%#{search_request['search']}%"),
                               Conditions::Comparison.new(:source_id, '$like', "%#{search_request['search']}%"),
                               Conditions::Comparison.new(:destination_system, '$like', "%#{search_request['search']}%"),
                               Conditions::Comparison.new(:destination_entity, '$like', "%#{search_request['search']}%"),
                               Conditions::Comparison.new(:destination_id, '$like', "%#{search_request['search']}%")])
                total = conditions.build_datamapper(::ExternalIntegration::Data).all.count
                data = conditions.build_datamapper(::ExternalIntegration::Data).all(:limit => limit, :offset => offset, :order => [:creation_date.desc])
              else
                data  = ::ExternalIntegration::Data.all(:limit => limit, :offset => offset, :order => [:creation_date.desc])
                total = ::ExternalIntegration::Data.count
              end
            else
              data  = ::ExternalIntegration::Data.all(:limit => limit, :offset => offset, :order => [:creation_date.desc])
              total = ::ExternalIntegration::Data.count
            end
            
            content_type :json
            {:data => data, :summary => {:total => total}}.to_json
          
          end
        
        end
        
        #
        # Get data integration
        #
        app.get "/api/integration/data", :allowed_usergroups => ['staff'] do

          data = ::ExternalIntegration::Data.all(:order => [:creation_date.desc])

          status 200
          content_type :json
          data.to_json

        end

        #
        # Get a data integration
        #
        app.get "/api/integration/data/:id", :allowed_usergroups => ['staff'] do
        
          data = ::ExternalIntegration::Dataget(params[:id].to_i)
          
          status 200
          content_type :json
          data.to_json
        
        end
        
        #
        # Create a data integration
        #
        app.post "/api/integration/data", :allowed_usergroups => ['staff'] do
        
          data_request = body_as_json(::ExternalIntegration::Data)
          data = ::ExternalIntegration::Data.create(data_request)
         
          status 200
          content_type :json
          data.to_json          
        
        end
        
        #
        # Updates a data integration
        #
        app.put "/api/integration/data", :allowed_usergroups => ['staff'] do
          
          data_request = body_as_json(::ExternalIntegration::Data)
                              
          if data = ::ExternalIntegration::Data.get(data_request.delete(:id).to_i)     
            data.attributes=data_request  
            data.save
          end
      
          content_type :json
          data.to_json        
        
        end
        
        #
        # Deletes a data integration
        #
        app.delete "/api/integration/data", :allowed_usergroups => ['staff'] do
        
          data_request = body_as_json(::ExternalIntegration::Data)
          
          key = data_request.delete(:id).to_i
          
          if data = ::ExternalIntegration::Data.get(key)
            data.destroy
          end
          
          content_type :json
          true.to_json
        
        end

      end
    end
  end
end