# At

`At` is a small library that allows you to access instance variables on an object as 
if they were attr_accessors for testing purposes.

## Install

Add to your Gemfile (usually within a :test or :development group):

```ruby
gem 'at'
```

Or simply install via RubyGems:

    gem install at

## Usage

If I want to test the output of the `full_name` method in my `User` class
below, I would normally have three options for testing all possible outcomes; 
initialize a `User` object for each test case, initialize one `User` object and 
use `instance_eval` to set the instance variables individually, or create 
attr_accessors for each instance variable I would like to test. In Rspec, I 
can use `assigns` to test the value of the instance variable, but I can't 
_get_ the value of the instance variable.

`At` solves these problems.

```ruby
class User
  def initialize(first_name=nil, last_name=nil)
    @first_name, @last_name = first_name, last_name
  end
  
  def full_name
    [@first_name, @last_name].compact.join(" ")
  end
end

describe User do
  describe "#full_name" do
    it "should output the full name correctly" do
      subject.at.first_name = "John"
      subject.at.last_name = "Doe"
      
      subject.full_name.should == "John Doe"
    end
  end
end
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

Copyright (c) 2010 Ryan Lewis. See LICENSE for details.