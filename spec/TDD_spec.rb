require "spec_helper"

RSpec.describe TDD do
  it "Has a version number" do
    expect(TDD::VERSION).not_to be nil
  end

  it "Has a class Food" do
      # Expect "Food" to be an object of class "Class"
      expect( Food.is_a?(Class) ).to be(true)
  end

  it "Food instances have a name property and we can get the value" do
      food_name = 'chocolate'
      some_food = Food.new(food_name)
      expect( some_food.name == food_name ).to be(true)
  end

end
