require 'version'

module At
  
  is_versioned
  
  class MethodToInstanceVariableProxy
    
    def initialize(parent)
      @parent = parent
    end
    
    def method_missing(meth, *args)
      @parent.instance_eval do
        
        if match = meth.to_s.match(/(.*)\=$/)
          value = args.length == 1 ? args.first : args
          instance_variable_set("@#{match[1]}", value)
        else
          if args.empty?
            instance_variable_get("@#{meth}")
          else
            value = args.length == 1 ? args.first : args
            instance_variable_set("@#{meth}", value)
          end
        end
        
      end
    end
    
  end
  
  def at
    @_method_to_instance_variable_proxy ||= MethodToInstanceVariableProxy.new(self)
  end
  
end

require 'at/import'
