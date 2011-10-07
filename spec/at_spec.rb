require 'spec_helper'

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
    subject { User.new }
    
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
