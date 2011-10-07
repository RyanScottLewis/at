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
