require_relative "base_record"

class Customer < BaseRecord
  attr_reader :name, :address

def initialize(properties = {})
  super(properties)#this is put in the child class to call the parent methods
  @name = properties[:name]
  @address = properties[:address]
end

def to_csv_row
  [@id, @name, @address]
end

def self.headers
  %w(id name address)
end
end
