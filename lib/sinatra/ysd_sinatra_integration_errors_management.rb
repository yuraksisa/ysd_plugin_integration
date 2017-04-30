module Sinatra
  module YitoExtension
    module IntegrationErrorsManagement

      def self.registered(app)

        #
        # Integration errors page
        #
        app.get '/admin/integration/errors', :allowed_usergroups => ['staff'] do 

          locals = {:integration_error_page_size => 20}
          load_em_page :integration_errors_management, nil, false, :locals => locals

        end

      end

    end
  end
end