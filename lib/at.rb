require 'pathname'
require 'active_support/concern'

module At
  extend ActiveSupport::Concern
  
  VERSION ||= Pathname.new(__FILE__).dirname.join('..', 'VERSION').read
  
  class MethodToInstanceVariableProxy
    def initialize(parent)
      @parent = parent
    end
    
    def method_missing(meth, *args, &blk)
      @parent.instance_eval do
        if match = meth.to_s.match(/(.*)\=$/)
          instance_variable_set("@#{match[1]}", args)
        else
          if block_given?
            instance_variable_set("@#{meth}", args.empty? ? args : blk.call)
          else
            if args.empty?
              instance_variable_get("@#{meth}")
            else
              instance_variable_set("@#{meth}", value)
            end
          end
        end
      end
    end
  end
  
  module InstanceMethods
    def at
      @_method_to_instance_variable_proxy ||= MethodToInstanceVariableProxy.new(self)
    end
  end
end

require 'at/core_ext'