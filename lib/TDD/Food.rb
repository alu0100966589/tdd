class Food
    @@nutrients_name = ['proteins', 'carbohydrates', 'fats']
    @@nutients_energy_value = [4, 4, 9] # The units are Kcal

    def self.nutrients_name
        @@nutrients_name
    end


    include Comparable
    attr_reader :name, :nutrient_quantities, :energetic_value

    def initialize( name, nutrient_quantities )
        raise( ArgumentError, 'Invalid number of nutrients values' ) unless (nutrient_quantities.length == @@nutrients_name.length)
        @name = name

        # How much of each nutrient this food has
        @nutrient_quantities = nutrient_quantities

        # Total energetic value of this food instance
        @energetic_value = 0
        @nutrient_quantities.length.times do |i|
            @energetic_value += @nutrient_quantities[i] * @@nutients_energy_value[i]
        end
    end

    def quantity_of_nutrient( n )
        # index method returns nil if the element doesn't exist
        index = @@nutrients_name.index( n )
        raise( ArgumentError, 'Invalid nutrient name' ) unless index

        return @nutrient_quantities[ index ]
    end

    def to_s
        result = @name + ': '
        (@nutrient_quantities.length - 1).times do |i|
            result += "#{@nutrient_quantities[i]}g of #{@@nutrients_name[i]}, "
        end
        result += "#{@nutrient_quantities[-1]}g of #{@@nutrients_name[-1]}"
    end

    # <=> operator, defined so instances could be comparable
    # @note We consider two foods to be equal if their name is equal
    # @return [Fixnum]
    def <=>(o)
        return name <=> o.name
    end

end
