# At

* [Gem](https://rubygems.org/gems/service)
* [Source](https://github.com/RyanScottLewis/at)
* [Documentation](http://rubydoc.info/gems/service/frames)

`At` is a small library provides an `at` method for all Objects which allows you to access instance variables
on an object as if they were accessors for testing purposes, usually within test setups and teardowns.

## Install

### Bundler: `gem 'at'` in `group :test`

### RubyGems: `gem install at`

### TL;DR

Basically, `at` directly translates this:

```ruby
value = user.instance_eval { @name }
user.instance_eval { @name = "#{value}!" }
```

into this:

```ruby
value = user.at.name
user.at.name = "#{value}!"
```

### Use Case

`lib/user.rb`

```ruby
class User
  
  def initialize(first_name=nil, last_name=nil)
    @first_name, @last_name = first_name, last_name
  end
  
  def full_name
    [@first_name, @last_name].compact.join(" ")
  end
  
end
```

`spec/spec_helper.rb`

```ruby
require 'user'
require 'at/setup'
```

`spec/user_spec.rb`

```ruby
describe User do
  
  describe '#full_name' do
    
    before :all do
      subject.at.first_name = 'John'
      subject.at.last_name = 'Doe'
    end
    
    it 'should output the full name correctly' do
      subject.full_name.should == 'John Doe'
    end
    
  end
  
end
```

Check out the specs for a better usage example.

## FAQ

### Why is this named "At"?

Because the at symbol (`@`) is how an instance variable is declared in Ruby!

### What if my class defines an `at` instance method?

`At` is included on the `Object` class, so when your class defines the `at` instance method, you are actually overwriting
the `At#at` method. Luckily, the `at` method is just an alias of the `_at` method, which you can use instead:

```ruby
describe Event do
  
  describe "#at" do
    
    let(:event_at) { DateTime.now }
    
    before(:all) { subject._at.at = event_at }
    
    it 'should return the DateTime the Event is happening' do
      subject.at.should == event_at
    end
    
  end
  
end
```

### How can I include the `at` and `_at` methods on a single object?

Include `At` to the object's class:

`lib/user.rb`

```ruby
class User
  
  def initialize(first_name=nil, last_name=nil)
    @first_name, @last_name = first_name, last_name
  end
  
  def full_name
    [@first_name, @last_name].compact.join(" ")
  end
  
end
```

`spec/spec_helper.rb`

```ruby
require 'user'
require 'at'

class User
  include At
end
```

`spec/user_spec.rb`

```ruby

describe User do
  
  describe '#full_name' do
    
    before :all do
      subject.at.first_name = 'John'
      subject.at.last_name = 'Doe'
    end
    
    it 'should output the full name correctly' do
      subject.full_name.should == 'John Doe'
    end
    
  end
  
end
```

### How can I include the `at` method outside of a test environment?

Same premise as the above answer:

```ruby
require 'at'

class User
  
  include At
  
  def initialize(first_name=nil, last_name=nil)
    @first_name, @last_name = first_name, last_name
  end
  
  def full_name
    [@first_name, @last_name].compact.join(" ")
  end
  
end
```

### How can I use instance variable delegation without the `at` method?

Simply use `At::InstanceVariableDelegator`:

```ruby
require 'at/instance_variable_delegator'

class Application
  
  class Config
    attr_reader :hostname, :port
  end
  
  attr_reader :config
  
  def initialize(&block)
    @config = Config.new
    
    configure(&block) if block_given?
  end
  
  def configure(&block)
    raise ArgumentError, 'block must be supplied' unless block_given?
    delegator = At::InstanceVariableDelegator.new(@config)
    
    block.call(delegator)
  end
  
end

# Usage:
app = Application.new
app.configure do |c|
  c.hostname = 'example.com'
  c.port = 8080
end

p app.config.hostname # => 'example.com'
p app.config.port     # => 8080
```

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright © 2012-2013 Ryan Scott Lewis <ryan@rynet.us>.

The MIT License (MIT) - See LICENSE for further details.
