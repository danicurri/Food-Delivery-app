require_relative "base_record"

class Order < BaseRecord
  attr_reader :meal, :employee, :customer
  def initialize(properties = {})
    super(properties)
    @delivered = properties[:delivered]
    @meal = properties[:meal]
    @employee = properties[:employee]
    @customer = properties[:customer]
  end

  def delivered?
    @delivered || false
  end

  def deliver!
    @delivered = true
  end
end

