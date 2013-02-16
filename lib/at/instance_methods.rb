require 'at/instance_variable_delegator'

module At
  
  # The instance methods to be included to Object
  module InstanceMethods
    
    # @return [InstanceVariableDelegator] The memoized InstanceVariableDelegator proxy instance for this Object instance
    def _at
      @_at ||= InstanceVariableDelegator.new(self)
    end
    
    alias_method :at, :_at
    
  end
  
end
