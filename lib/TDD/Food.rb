class Food
    @@nutrients_name = ['proteins', 'carbohydrates', 'fats']

    def self.nutrients_name
        @@nutrients_name
    end


    attr_reader :name, :nutrient_quantities

    def initialize( name, nutrient_quantities )
        raise( ArgumentError, 'Invalid number of nutrients values' ) unless (nutrient_quantities.length == @@nutrients_name.length)
        @name = name

        # How much of each nutrient this food has
        @nutrient_quantities = nutrient_quantities
    end

    def quantity_of_nutrient( n )
        # index method returns nil if the element doesn't exist
        index = @@nutrients_name.index( n )
        raise( ArgumentError, 'Invalid nutrient name' ) unless index

        return @nutrient_quantities[ index ]
    end


end
