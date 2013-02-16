require 'version'
require 'at/instance_methods'

# `At` is a small library provides an `at` method for all Objects which allows you to access instance variables
# on an object as if they were accessors for testing purposes, usually within test setups and teardowns
module At
  is_versioned
end

# Here, we include At::InstanceMethods to the Object class.
class Object
  include At::InstanceMethods
end
