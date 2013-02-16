module At
  
  # InstanceVariableDelegator is a simply class which delegates it's methods it an object's instance variables.
  class InstanceVariableDelegator
    
    # @param [Object] parent The object to delegate accessors to it's instance variables.
    def initialize(parent)
      @parent = parent
    end
    
    # If the method ends with an equal sign (`=`), we will set the instance variable on the @parent object.
    # Otherwise, we will /get/ the instance variable on the @parent object.
    def method_missing(meth, value=nil)
      @parent.instance_eval do
        match = meth.to_s.match(/(.*)\=$/)
        raise ArgumentError, '`value` must be given' if match && value.nil?
        raise ArgumentError, '`value` must not be given' if !match && !value.nil?
        
        match ? instance_variable_set("@#{match[1]}", value) : instance_variable_get("@#{meth}")
      end
    end
    
  end
  
end
