Gem::Specification.new do |s|
  s.name    = "ysd_plugin_integration"
  s.version = "0.1.5"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2012-05-09"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','views/**/*.erb','i18n/**/*.yml','static/**/*.*'] 
  s.description = "Integration integration"
  s.summary = "Integration integration"

  s.add_runtime_dependency "json"  
  
  s.add_runtime_dependency "ysd_md_integration"   # Integration model

  s.add_runtime_dependency "ysd_yito_core"        # Page loading
  s.add_runtime_dependency "ysd_yito_js"          # Yito JS library

  s.add_runtime_dependency "ysd_core_plugins"     # Plugins system
  
end