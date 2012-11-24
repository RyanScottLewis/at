require 'pathname'

__LIB__ ||= Pathname.new(__FILE__).join('..', '..').expand_path
$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'at'

class Object
  include At
end
