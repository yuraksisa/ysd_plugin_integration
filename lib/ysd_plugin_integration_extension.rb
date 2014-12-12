require 'ysd-plugins_viewlistener' unless defined?Plugins::ViewListener

#
# Social Mail Extension
#
module Huasi

  class IntegrationExtension < Plugins::ViewListener
                
    # ========= Menu =====================
    
    #
    # It defines the admin menu menu items
    #
    # @return [Array]
    #  Menu definition
    #
    def menu(context={})
      
      app = context[:app]
       
      menu_items = [{:path => '/configuration/accounts',
                     :options => {:title => app.t.integration_admin_menu.external_service_account_management,
                                  :link_route => "/admin/external-service-accounts",
                                  :description => 'It defines the accounts to integrate external services as twitter, facebook and picasa',
                                  :module => :integration,
                                  :weight => 9}}]
       
   
    end
  
    # ========= Routes ===================
    
    # routes
    #
    # Define the module routes, that is the url that allow to access the funcionality defined in the module
    #
    #
    def routes(context={})
    
      routes = [{:path => '/admin/external-service-accounts',
                 :regular_expression => /^\/admin\/external-service-accounts/,
                 :title => 'External Service Accounts',
                 :description => 'It defines the accounts to integrate external services as twitter, facebook and picasa',
                 :fit => 1,
                 :module => :integration}]
    
    end   
    
  end #IntegrationExtension
end #Social