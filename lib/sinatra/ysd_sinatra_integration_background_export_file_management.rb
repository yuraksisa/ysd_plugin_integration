module Sinatra
  module YitoExtension
    module BackgroundExportFileManagement

      def self.registered(app)

        #
        # Integration export files
        #
        app.get '/admin/integration/background-export-files', :allowed_usergroups => ['staff'] do 
        
           @export_files = ExternalIntegration::BackgroundExportFile.all(conditions:{:valid_until.gte => DateTime.now},
           	                                                             order: :created_at.desc)
           load_page :background_export_files

        end
   
        # 
        # Download a file
        #     
        app.get	'/admin/integration/export/:id', :allowed_usergroups => ['staff'] do

          if export_file = ExternalIntegration::BackgroundExportFile.get(params[:id]) and
          	 File.exists?(export_file.file_path) 
            send_file export_file.file_path,
                      disposition: 'attachment', filename: export_file.file_name
          else
          	status 404
          end

        end

        # 
        # Delete a file
        #     
        app.post '/admin/integration/export/:id', :allowed_usergroups => ['staff'] do

          if params[:_method] == 'DELETE'
	          if export_file = ExternalIntegration::BackgroundExportFile.get(params[:id]) and
	          	 File.exists?(export_file.file_path) 
	          	 File.delete(export_file.file_path)
	          	 export_file.destroy
	          	 flash[:notice] = 'Fichero eliminado'
	          	 redirect '/admin/integration/background-export-files'
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