class Food
    @@nutrients_name = ["proteins", "carbohydrates", "fats"]

    def self.nutrients_name
        @@nutrients_name
    end


    attr_reader :name, :nutrient_quantities

    def initialize( name, nutrient_quantities )
        raise( ArgumentError, "Invalid number of nutrients values" ) unless (nutrient_quantities.length == @@nutrients_name.length)
        @name = name
        @nutrient_quantities = nutrient_quantities
    end


end
