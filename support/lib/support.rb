require 'support/core_ext/string/colorize'
require 'support/file_set'
require 'support/utils'

if ENV["AS_VERSION"]
  require 'active_support/core_ext/string/output_safety'      
  require 'active_support/core_ext/object/blank'              
  require 'active_support/core_ext/hash/keys'                 
  require 'active_support/core_ext/hash/indifferent_access'   
  require 'active_support/core_ext/hash/reverse_merge'        
  require 'active_support/core_ext/module/aliasing'          
  require 'active_support/core_ext/array/extract_options'    
  require 'active_support/core_ext/hash/slice'                
  begin
    require 'active_support/core_ext/object/deep_dup'  
  rescue LoadError
    require 'active_support/core_ext/hash/deep_dup'  
  end
end

if defined?(I18n) && !defined?(RIZZ_I18N_LOCALE)
  RIZZ_I18N_LOCALE = true
  I18n.load_path += Dir["#{File.dirname(__FILE__)}/support/locale/*.yml"]
end
