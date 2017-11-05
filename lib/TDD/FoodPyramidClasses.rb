class FoodGroup
    attr_reader :list
    def initialize
        @list = Dll.new
    end 
end

class EggMilkAndDerivatives < FoodGroup
end

class MeatAndDerivatives < FoodGroup
end

class Fish < FoodGroup
end

class OilsAndSweets < FoodGroup
end

class CarbohydrateRich < FoodGroup
end

class Vegetables < FoodGroup
end

class Fruits < FoodGroup
end
