# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "at"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Scott Lewis"]
  s.date = "2012-11-24"
  s.description = "# At\n\n`At` is a small library that allows you to access instance variables on an object as \nif they were `attr_accessor`s for testing purposes.\n\nBasically, `at` directly translates this:\n\n```ruby\nvalue = object.instance_eval { @instance_variable }\nobject.instance_eval { @instance_variable = \"\#{value}!\" }\n```\n\ninto this:\n\n```ruby\nvalue = object.at.instance_variable\nobject.at.instance_variable = \"\#{value}!\"\n```\n\n## Install\n\n### Bundler: `gem 'at'`\n\n### RubyGems: `gem install at`\n\n## Usage\n\nIf I want to test the output of the `full_name` method in my `User` class\nbelow, I would normally have three options for testing all possible outcomes; \ninitialize a `User` object for each test case, initialize one `User` object and \nuse `instance_eval` to set the instance variables individually, or create \n`attr_accessor`s for each instance variable I would like to test. In Rspec, I \ncan use `assigns` to test the value of the instance variable, but I can't \n_get_ the value of the instance variable.\n\n`At` solves these problems.\n\n```ruby\nrequire 'at'\n\nclass User\n  def initialize(first_name=nil, last_name=nil)\n    @first_name, @last_name = first_name, last_name\n  end\n  \n  def full_name\n    [@first_name, @last_name].compact.join(\" \")\n  end\nend\n\ndescribe User, '#full_name' do\n  it 'should output the full name correctly' do\n    subject.at.first_name = 'John'\n    subject.at.last_name = 'Doe'\n      \n    subject.full_name.should == 'John Doe'\n  end\nend\n```\n\nCheck out the specs for a better usage example.\n\n## Contributing\n\n* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet\n* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it\n* Fork the project\n* Start a feature/bugfix branch\n* Commit and push until you are happy with your contribution\n* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.\n* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.\n\n## Copyright\n\nCopyright \u{a9} 2012 Ryan Scott Lewis <ryan@rynet.us>.\n\nThe MIT License (MIT) - See LICENSE for further details."
  s.email = "ryan@rynet.us"
  s.files = [".yardoc/checksums", ".yardoc/object_types", ".yardoc/objects/root.dat", ".yardoc/proxy_types", "Gemfile", "Gemfile.lock", "Guardfile", "LICENSE", "README.md", "Rakefile", "VERSION", "at.gemspec", "lib/at.rb", "lib/at/import.rb", "spec/at_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/RyanScottLewis/at"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Easily access instance variables on your objects as if they were attributes."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<version>, ["~> 1.0.0"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 2.1"])
      s.add_development_dependency(%q<guard-yard>, ["~> 2.0"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_development_dependency(%q<fuubar>, ["~> 1.1"])
      s.add_development_dependency(%q<redcarpet>, ["~> 2.2.2"])
      s.add_development_dependency(%q<github-markup>, ["~> 0.7"])
    else
      s.add_dependency(%q<version>, ["~> 1.0.0"])
      s.add_dependency(%q<guard-rspec>, ["~> 2.1"])
      s.add_dependency(%q<guard-yard>, ["~> 2.0"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_dependency(%q<fuubar>, ["~> 1.1"])
      s.add_dependency(%q<redcarpet>, ["~> 2.2.2"])
      s.add_dependency(%q<github-markup>, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<version>, ["~> 1.0.0"])
    s.add_dependency(%q<guard-rspec>, ["~> 2.1"])
    s.add_dependency(%q<guard-yard>, ["~> 2.0"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
    s.add_dependency(%q<fuubar>, ["~> 1.1"])
    s.add_dependency(%q<redcarpet>, ["~> 2.2.2"])
    s.add_dependency(%q<github-markup>, ["~> 0.7"])
  end
end
