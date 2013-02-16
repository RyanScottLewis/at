# At

`At` is a small library provides an `at` method for all Objects which allows you to access instance variables
on an object as if they were accessors for testing purposes, usually within test setups and teardowns.

## Install

### Bundler: `gem 'at'` in `group :test`

### RubyGems: `gem install at`

## Usage

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
require 'at'
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

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright © 2012 Ryan Scott Lewis <ryan@rynet.us>.

The MIT License (MIT) - See LICENSE for further details.
