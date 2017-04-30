module Sinatra
  module YitoExtension
    module IntegrationDataManagement

      def self.registered(app)

        #
        # Integration data page
        #
        app.get '/admin/integration/data', :allowed_usergroups => ['staff'] do 

          locals = {:integration_data_page_size => 20}
          load_em_page :integration_data_management, nil, false, :locals => locals

        end

      end

    end
  end
end