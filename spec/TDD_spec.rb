require "spec_helper"

RSpec.describe TDD do
  it "Has a version number" do
    expect(TDD::VERSION).not_to be nil
  end

  it "Has a class Food" do
      # Expect "Food" to be an object of class "Class"
      expect( Food.is_a?(Class) ).to be(true)
  end

  before :all do
      @expected_nutrients_names = ["proteins", "carbohydrates", "fats"]
      @food_nutrient_quantities = [1, 2, 3]
      @food_name = 'chocolate'
      @some_food = Food.new(@food_name, @food_nutrient_quantities)
  end

  it "Food instances have a name property and we can get the value" do
      expect( @some_food.name == @food_name ).to be(true)
  end

  it "Food has a static member array for storing the nutrients names" do
      expect( Food.nutrients_name == @expected_nutrients_names ).to be(true)
  end

  it "Food instances have an array of nutrients" do
      expect( @some_food.nutrient_quantities == @food_nutrient_quantities ).to be(true)
  end

  it "Array of nutrients have the same number of elements than the array of nutrients names" do
      expect( @some_food.nutrient_quantities.length == @expected_nutrients_names.length ).to be(true)
  end

  it "An exception has to be thrown if the number of nutrients is not the same as expected" do
      expect{ Food.new(@food_name, []) }.to raise_error(ArgumentError)
      expect{ Food.new(@food_name, @food_nutrient_quantities * 2) }.to raise_error(ArgumentError)
  end

  it "Food instances have to have getters for the quantity of each nutrient" do
      # We can take the whole array of nutrients, but that we already have implemented. Now we
      # want to know how much of a single nutrient a food instance has

      # We want to take the quantity of some nutrient by its position
      expect( @some_food.nutrient_quantities[0] == @food_nutrient_quantities[0] ).to be(true)

      # Or by the name of the nutrient
      expect( @some_food.quantity_of_nutrient( "proteins" ) == @food_nutrient_quantities[0] ).to be(true)
      expect( @some_food.quantity_of_nutrient( "fats" ) == @food_nutrient_quantities[2] ).to be(true)
      expect( @some_food.quantity_of_nutrient( @expected_nutrients_names[0] ) == @food_nutrient_quantities[0] ).to be(true)

      # If we want a nutrient that doesn't exist we expect an error
      expect{ @some_food.quantity_of_nutrient( "asdasdasda" ) }.to raise_error(ArgumentError)
      expect{ @some_food.quantity_of_nutrient( "FaTs" ) }.to raise_error(ArgumentError)
  end

  it "Food instances have to have a property that returns the total energetic value of the food" do
      food = Food.new( "fake fish", [1, 2, 3] )
      expected_energetic_value = 1*4 + 2*4 + 3*9

      expect( food.energetic_value == expected_energetic_value ).to be(true)
  end

  it "Food instances have to have implemented to_s" do
      food = Food.new( "fake meat", [1, 2, 3] )
      expected_str = 'fake meat: 1g of proteins, 2g of carbohydrates, 3g of fats'

      expect( food.to_s == expected_str ).to be( true )
      expect( food.to_s == 'asdasdasd' ).to be( false )
  end

end



RSpec.describe "Task number 7" do
	context "Link list node expectations" do
        before :each do
            @node = DllNode.new(nil, 0, nil)
        end
		it "There need to be a dll node class" do
            expect( DllNode.is_a?(Class) ).to be(true)
		end 
		it "The node has to have value and pointers to prev and next" do
           expect( @node.prev == nil ).to be(true) 
           expect( @node.next == nil ).to be(true) 
           expect( @node.value == 0 ).to be(true) 
           expect( @node.value == 'asdasd' ).to be(false) 
		end 
	end 

	context "Link list node expectations" do
        before :each do
            @dll = Dll.new
        end
		it "There need to be a double link list class" do
            expect( Dll.is_a?(Class) ).to be(true)
		end 
        it "Expect an insert head method in Dll instances" do
            expect{ @dll.insert_head(2) }.not_to raise_error
        end
        it "Expect an insert tail method in Dll instances" do
            expect{ @dll.insert_tail(3) }.not_to raise_error
        end
        it "Expect a getter for the head node" do
            @dll.insert_head(3)
            expect( @dll.head.value == 3 ).to be(true)
        end
        it "Expect a getter for the tail node" do
            @dll.insert_tail(90)
            expect( @dll.tail.value == 90 ).to be(true)
        end
    end
end
