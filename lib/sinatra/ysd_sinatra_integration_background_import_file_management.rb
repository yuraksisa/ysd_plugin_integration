module Sinatra
  module YitoExtension
    module BackgroundImportFileManagement

      def self.registered(app)

        #
        # Integration export files
        #
        app.get '/admin/integration/background-import-files', :allowed_usergroups => ['staff'] do 
        
           @import_files = ExternalIntegration::BackgroundImportFile.all(order: :created_at.desc)
           load_page :background_import_files

        end
      
        # 
        # Delete a file
        #     
        app.post '/admin/integration/import/:id', :allowed_usergroups => ['staff'] do

          if params[:_method] == 'DELETE'
            if import_file = ExternalIntegration::BackgroundImportFile.get(params[:id]) and
               File.exists?(import_file.file_path) 
               File.delete(import_file.file_path)
               import_file.destroy
               flash[:notice] = 'Fichero eliminado'
               redirect '/admin/integration/background-import-files'
            else
              status 404
            end
          else
            status 404
          end   

        end      

      end  	
    end
  end
end      