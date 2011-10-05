#!/bin/ruby

Gem::Specification.new do |s|
  s.author = "Ryan Scott Lewis"
  s.email = "c00lryguy@gmail.com"
  s.homepage = "http://github.com/c00lryguy/at"
  
  s.description = "Adds a proxy to set or get instance variables on an object."
  s.summary = "Easily access instance variables on your objects as if they were attributes."
  
  s.require_paths = ["lib"]
  
  s.name = File.basename(__FILE__, ".gemspec")
  s.version = File.read("VERSION")
  
  s.files = Dir['{lib,spec}/**/*']
  
  # Add files you *might* use in ALL projects! The point is to never need to change.
  %W{Gemfile.lock *.gemspec README.* README Rakefile VERSION LICENSE}.each do |file|
    s.files.unshift(file) if File.exists?(file)
  end
  
  # Add files you *might* use in ALL projects! The point is to never need to change.
  %W{README.* README VERSION LICENSE}.each do |file|
    (s.extra_rdoc_files ||= []).unshift(file) if File.exists?(file)
  end
  
  s.test_files = Dir['spec/**/*']
  
  s.add_development_dependency("rspec", "~> 2.6.0")
  s.add_development_dependency("fuubar", "~> 0.0.6")
end
