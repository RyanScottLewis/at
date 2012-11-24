require 'spec_helper'

class Configuration
  attr_reader :configuration
  
  def initialize
    @configuration = "default"
  end
end

describe Configuration do
  describe "#configuration" do
    it "should return the @configuration instance variable" do
      subject.configuration.should == "default"
      subject.at.configuration = "the result"
      subject.configuration.should == "the result"
    end
  end
end

#===-----------------------------------------------------------------------===#

class User
  def initialize(first_name=nil, last_name=nil)
    @first_name, @last_name = first_name, last_name
  end
  
  def full_name
    [@first_name, @last_name].compact.join(" ")
  end
end

describe User do
  describe "#initialize" do
    subject { User.new("John", "Doe") }
    
    it "should correctly set the instance variables on the User instance" do
      subject.at.first_name.should == "John"
      subject.at.last_name.should == "Doe"
    end
  end
  
  describe "#full_name" do
    it "should correctly output the full name" do
      subject.at.first_name = "John"
      subject.at.last_name = "Doe"
      
      subject.full_name.should == "John Doe"
    end
  end
  
  describe "#first_name" do
    it "should raise a NoMethodError" do
      Proc.new { subject.first_name }.should raise_error(NoMethodError)
    end
  end
  
  describe "#last_name" do
    it "should raise a NoMethodError" do
      Proc.new { subject.last_name }.should raise_error(NoMethodError)
    end
  end
end

#===-----------------------------------------------------------------------===#

require 'net/http'
require 'active_support/core_ext/object/to_query'

module HtmlDownloader
  def base_uri(_base_uri)
    @base_uri = _base_uri.gsub(/\/$/, '').gsub(/https?:\/\//, '')
  end
  
  def get(path, params={})
    path.gsub!(/^\//, '')
    full_path = params == {} ? "/#{path}" : "/#{path}?#{params.to_param}"
    Net::HTTP.get_print(@base_uri, full_path)
  end
end

class Twitter
  extend HtmlDownloader
  
  base_uri 'http://search.twitter.com'
  
  def self.search(params={})
    @cache ||= Hash.new { |h, k| h[k] = get('/search.json', params) }
    @cache[params]
  end
end

describe Twitter do
  describe "#search" do
    it "should not make an HTTP request for the same params twice" do
      Twitter.at.cache = {
        { :q => 'test' } => "{'some':'json response'}"
      }
      
      Net::HTTP.should_receive(:get_print).never
      
      Twitter.search(:q => "test").should == "{'some':'json response'}"
    end
  end
end