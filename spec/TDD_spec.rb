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

	context "Link list expectations" do
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
        it "Expect insert_tail to work well after several calls" do
            for i in (0...10)
                @dll.insert_tail(i)
            end
            currentNode = @dll.head
            for i in (0...10)
                expect( currentNode.value == i ).to be(true)
                currentNode = currentNode.next
            end
        end
        it "Expect insert_head to work well after several calls" do
            for i in (0...10)
                @dll.insert_head(i)
            end
            currentNode = @dll.tail
            for i in (0...10)
                expect( currentNode.value == i ).to be(true)
                currentNode = currentNode.prev
            end
        end
        it "Expect a extract head method in Dll instances" do
            expect{ @dll.extract_head }.not_to raise_error
        end
        it "Expect a extract tail method in Dll instances" do
            expect{ @dll.extract_tail }.not_to raise_error
        end
        it "Expect the extract head method to remove the head node" do
            @dll.insert_head(1)
            @dll.insert_head(2)
            @dll.extract_head()
            expect( @dll.head.value == 1 ).to be(true) 
            @dll.extract_head
            expect( @dll.head == nil ).to be(true) 
        end
        it "Expect the extract tail method to remove the tail node" do
            @dll.insert_tail(1)
            @dll.insert_tail(2)
            @dll.extract_tail()
            expect( @dll.tail.value == 1 ).to be(true) 
            @dll.extract_tail
            expect( @dll.tail == nil ).to be(true) 
        end
    end

	context "Food pyramid classes expectations" do
        it "Expecting the different food classes to exist" do
            expect( EggMilkAndDerivatives.is_a?(Class) ).to be(true)
            expect( MeatAndDerivatives.is_a?(Class) ).to be(true)
            expect( Fish.is_a?(Class) ).to be(true)
            expect( OilsAndSweets.is_a?(Class) ).to be(true)
            expect( CarbohydrateRich.is_a?(Class) ).to be(true)
            expect( Vegetables.is_a?(Class) ).to be(true)
            expect( Fruits.is_a?(Class) ).to be(true)
        end 
        before :each do
            @name = "name"
            @nutrient_quantities = [1,2,3]
            @foods = [
	            EggMilkAndDerivatives.new(@name, @nutrient_quantities),
	            MeatAndDerivatives.new(@name, @nutrient_quantities),
	            Fish.new(@name, @nutrient_quantities),
	            OilsAndSweets.new(@name, @nutrient_quantities),
	            CarbohydrateRich.new(@name, @nutrient_quantities),
	            Vegetables.new(@name, @nutrient_quantities),
	            Fruits.new(@name, @nutrient_quantities)
            ]
        end
        it "Expecting the different food classes to be Food" do
            for food in @foods
                expect( food.is_a?(Food) ).to be(true)
            end
        end 
        it "Expecting the different food classes to initialize" do
            for food in @foods
                expect( food.name == @name).to be(true)
                expect( food.nutrient_quantities == @nutrient_quantities ).to be(true)
            end
        end
    end
end


RSpec.describe "Assignment number 8" do
    context 'Food instances have to be comparable' do
        before :each do
            @chocolate1 = OilsAndSweets.new('chocolate', [0, 5, 5])
            @chocolate2 = OilsAndSweets.new('white chocolate', [0, 5, 5])
            @apple = Fruits.new('apple', [1, 1, 0])
        end

        it 'Food instances have to have the == operator' do
            expect( @chocolate1 == @chocolate2 ).to be(true)
            expect( @chocolate2 == @apple ).to be(false)
        end

        it 'Food instances have to have the != operator' do
            expect( @chocolate1 != @apple ).to be(true)
        end

        it 'Food has to include Comparable' do
            expect( Food.include? Comparable ).to be(true)
        end
    end

    context 'Dll has to be enumerable' do
        before :each do
            @dll = Dll.new
            for i in (0...10)
                @dll.insert_tail(i)
            end

            @foodArray = [
                OilsAndSweets.new('chocolate', [3, 3, 3]),
                Vegetables.new('carrot', [2, 2, 2]),
                Fruits.new('apple', [1, 1, 1])
            ]

            @sortedFoodArray = [
                Fruits.new('apple', [1, 1, 1]),
                Vegetables.new('carrot', [2, 2, 2]),
                OilsAndSweets.new('chocolate', [3, 3, 3])
            ]

            @foodList = Dll.new
            @foodArray.each do |food|
                @foodList.insert_tail(food)
            end
        end
        
        it 'Dll has to have an each method' do
            expect{ @dll.each{ |i| i+1 } }.not_to raise_error
        end

        it 'Dll has to include Enumerable' do
            expect( Dll.include? Enumerable ).to be(true)
        end

        it 'Expect the list to work well with food instances' do
           expect( @foodList.to_a == @foodArray ).to be(true) 
           expect( @foodList.sort.to_a == @sortedFoodArray).to be(true)           
        end
    end
end


RSpec.describe "Assignment number 9" do
    before :each do
        @foods = [
            Food.new('random', [1,1,1]),
            Fruits.new('apple', [1,1,0]),
            Vegetables.new('carrot', [5,2,0])
        ]

        @metrics1 = [
            {
                food_metrics: [1.1, 1.2, 1.3],
                glucose_metrics: [1.1, 1.2, 1.3]
            }
        ]

        @metrics2 = [
            {
                food_metrics: [1,2,3],
                glucose_metrics: [1,2,3]
            },
            {
                food_metrics: [1.1, 2.2],
                glucose_metrics: [2.0, 3.0]
            }
        ]

        @expected_igs = [1.0, 68.33]
    end

    context 'Defining helper functions to calculate the glycemic index' do
        it 'Food instances have to have a glycemic index getter' do
            @foods.each do |food|
                expect(food.glycemic_index == nil).to be(true)
            end 
        end

        it 'Food instances have to have an iauc method' do
            @foods.each do |food|
                expect{ food.iauc([1,2,3,4]) }.not_to raise_error
                expect{ food.iauc([]) }.to raise_error(ArgumentError)
                expect{ food.iauc([1]) }.to raise_error(ArgumentError)
                expect( food.iauc([1,2,3]) ).to eql(5.0)
            end 
        end

        it 'Food instances have to have an individual glycemic index method' do
            @foods.each do |food|
                expect{ food.individual_gi([1,2,3], [4,5,6]) }.not_to raise_error
                expect{ food.individual_gi([1,2,3], [5,6]) }.to raise_error(ArgumentError)
                expect( food.individual_gi([0,1,2], [0,2,1]) ).to eql(80.0)
                expect( food.individual_gi([0,1,2], [0,1,2]) ).to eql(100.0)
            end
        end
    end

    context 'Defining the glycemic index method' do
        before :each do
            @metrics1 = [
                {
                    food_metrics: [1.1, 1.2, 1.3],
                    glucose_metrics: [1.1, 1.2, 1.3]
                }
            ]

            @metrics2 = [
                {
                    food_metrics: [1,2,3],
                    glucose_metrics: [1,2,3]
                },
                {
                    food_metrics: [1.1, 2.2],
                    glucose_metrics: [2.0, 3.0]
                }
            ]

            @expected_igs = [100.0, 68.33]
        end

        it 'Food instances have to have a glycemic index method' do
            @foods.each do |food|
                expect{ food.gi(@metrics1) }.not_to raise_error
            end 
        end

        it 'Glycemc index has to work as expected' do
            @foods.each do |food|
                expect( food.gi(@metrics1).glycemic_index ).to eql(@expected_igs[0])
                expect( food.gi(@metrics2).glycemic_index.round(2)).to eql(@expected_igs[1])
            end
        end
    end

end

RSpec.describe "Assignment number 10" do
    before :each do
        @food = [
            EggMilkAndDerivatives.new('fried egg', [14.1, 0.0, 19.5]),
            EggMilkAndDerivatives.new('milk', [3.3, 4.8, 3.2]),
            EggMilkAndDerivatives.new('yogurt', [3.8, 4.9, 3.8]),
            MeatAndDerivatives.new('pork', [21.5, 0.0, 6.3]),
            MeatAndDerivatives.new('beef', [21.1, 0.0, 3.1]),
            MeatAndDerivatives.new('chicken', [20.6, 0.0, 5.6]),
            Fish.new('cod', [17.7, 0.0, 0.4]),
            Fish.new('tuna', [21.5, 0.0, 15.5]),
            Fish.new('salmon', [19.9, 0.0, 13.6]),
            OilsAndSweets.new('olive oil', [0.0, 0.2, 99.6]),
            OilsAndSweets.new('butter', [0.7, 0.0, 83.2]),
            OilsAndSweets.new('chocolate', [5.3, 47.0, 30.0]),
            CarbohydrateRich.new('sugar', [0.0, 99.8, 0.0]),
            CarbohydrateRich.new('rice', [6.8, 77.7, 0.6]),
            CarbohydrateRich.new('lentils', [23.5, 52.0, 1.4]),
            CarbohydrateRich.new('potatoe', [2.0, 15.4, 0.1]),
            Vegetables.new('tomato', [1.0, 3.5, 0.2]),
            Vegetables.new('onion', [1.3, 5.8, 0.3]),
            Vegetables.new('pumpkin', [1.1, 4.8, 0.1]),
            Fruits.new('apple', [0.3, 12.4, 0.4]),
            Fruits.new('banana', [1.2, 21.4, 0.2]),
            Fruits.new('pear', [0.5, 12.7, 0.3])
        ]
        
        @simpler_test = [
            3.2,
            1.4,
            6.3,
            3.2,
            0,
            -2.14,
            5.2,
            -100
        ]
        
        @simpler_test_ordered = [
            -100,
            -2.14,
            0,
            1.4,
            3.2,
            3.2,
            5.2,
            6.3
        ]
    end
    
    context 'Sorting algorithms' do
        it 'Array should have a sort_for method' do
            expect{ @simpler_test.sort_for }.not_to raise_error
            expect( @simpler_test.sort_for ).to eql(@simpler_test_ordered)
        end

        it 'Array should have a sort_each method' do
            expect{ @simpler_test.sort_each }.not_to raise_error
            expect( @simpler_test.sort_each ).to eql(@simpler_test_ordered)
        end

        it 'Array should have a sort method' do
            expect{ @simpler_test.sort }.not_to raise_error
            expect( @simpler_test.sort ).to eql(@simpler_test_ordered)
        end
        
        it 'All sorts should end with the same result' do
            a = @food.sort_for
            b = @food.sort_each
            c = @food.sort
            
            expect( a == b ).to be(true)
            expect( b == c ).to be(true)
            
            @food.length.times.each do |i|
                expect( a[i] == b[i] ).to be(true)
                expect( b[i] == c[i] ).to be(true)
            end
        end
    end
    
    context "Benchmark" do
        it "Sorting benchmark" do
            n = 1000
            Benchmark.bm(6) do |x|
                x.report("For: " ){ n.times{@food.sort_for} }
                x.report("Each: "){ n.times{@food.sort_each} }
                x.report("Sort: "){ n.times{@food.sort} }
            end
        end
    end
end