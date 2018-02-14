require_relative "base_repository"
require_relative "../models/meal"

class MealRepository < BaseRepository
  private

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:proce].to_i
    Meal.new(row)
  end
end
