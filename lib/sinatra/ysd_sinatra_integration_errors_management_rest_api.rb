module Sinatra
  module YitoExtension
    #
    # Integration Data REST API
    #
    module IntegrationErrorsManagementRESTApi

      def self.registered(app)

        #                    
        # Query errors integration
        #
        ["/api/integration/errors","/api/integration/errors/page/:page"].each do |path|
          
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
                               Conditions::Comparison.new(:destination_entity, '$like', "%#{search_request['search']}%")])
                total = conditions.build_datamapper(::ExternalIntegration::Error).all.count
                data = conditions.build_datamapper(::ExternalIntegration::Error).all(:limit => limit, :offset => offset, :order => [:creation_date.desc])
              else
                data  = ::ExternalIntegration::Error.all(:limit => limit, :offset => offset, :order => [:creation_date.desc])
                total = ::ExternalIntegration::Error.count
              end
            else
              data  = ::ExternalIntegration::Error.all(:limit => limit, :offset => offset, :order => [:creation_date.desc])
              total = ::ExternalIntegration::Error.count
            end
            
            content_type :json
            {:data => data, :summary => {:total => total}}.to_json
          
          end
        
        end
        
        #
        # Deletes an integration error
        #
        app.delete "/api/integration/error", :allowed_usergroups => ['staff'] do
        
          data_request = body_as_json(::ExternalIntegration::Error)
          
          key = data_request.delete(:id).to_i
          
          if data = ::ExternalIntegration::Error.get(key)
            data.destroy
          end
          
          content_type :json
          true.to_json
        
        end

      end
    end
  end
end