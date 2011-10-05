require 'pathname'
require Pathname.new(__FILE__).dirname.join('..', 'at').to_s

class Object
  include At
end
