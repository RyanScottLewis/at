require 'version'

# `At` is a small library provides an `at` method for all Objects which allows you to access instance variables
# on an object as if they were accessors for testing purposes, usually within test setups and teardowns
module At
  is_versioned
  
  require 'at/instance_variable_delegator'
  # @return [InstanceVariableDelegator] The memoized InstanceVariableDelegator proxy instance for this Object instance
  def _at
    @_at ||= InstanceVariableDelegator.new(self)
  end
  
  alias_method :at, :_at
  
end

