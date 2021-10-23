require 'active_support/lazy_load_hooks'
require 'armg'
 
 ActiveSupport.on_load(:active_record) do
   module Armg
    class CustomSerializer
    end
  end
end
