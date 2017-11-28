class Food
    # Names of the nutrients
    @@nutrients_name = ['proteins', 'carbohydrates', 'fats']
    # Energy value (in Kcal) that each nutrient type gives
    @@nutients_energy_value = [4, 4, 9]

    # Getter for the nutrients name
    # @return [Array<String>] Array with the names of the nutrients
    def self.nutrients_name
        @@nutrients_name
    end


    include Comparable

    # @return [String] Name of the food
    attr_reader :name

    # @return [Array<Float>] Quantity in grams of each nutrient
    attr_reader :nutrient_quantities

    # @return [Float] Total energetic value of the food
    attr_reader :energetic_value

    # @return [Float | nil] Glycemic index for this food if it is calculated, nil otherwise
    attr_reader :glycemic_index

    # @param name [String] Name of the food
    # @param nutrient_quantities [Array<FixNum>] An array with the values for the quantities of nutrients 0:grams of proteins, 1:grams of carbohydrates, 2:grams of fats
    def initialize( name, nutrient_quantities )
        raise( ArgumentError, 'Invalid number of nutrients values' ) unless (nutrient_quantities.length == @@nutrients_name.length)
        @name = name.downcase

        # How much of each nutrient this food has
        @nutrient_quantities = nutrient_quantities

        # Total energetic value of this food instance
        @energetic_value = 0
        @nutrient_quantities.length.times do |i|
            @energetic_value += @nutrient_quantities[i] * @@nutients_energy_value[i]
        end

        # Setting the glycemic index to a default value
        @glycemic_index = nil
    end

    # Given the name of a nutrient, #quantity_of_nutrient returns the quantity (in grams) of that nutrient
    # @param n [String] The name of the nutrient. The value has to be one of "proteins", "carbohydrates", "fats"
    # @return [Float] The quantity (in grams) of the nutrient requested that the food has
    def quantity_of_nutrient( n )
        # index method returns nil if the element doesn't exist
        index = @@nutrients_name.index( n )
        raise( ArgumentError, 'Invalid nutrient name' ) unless index

        return @nutrient_quantities[ index ]
    end

    # to_s method
    # @return [String] The format is "<food_name>: <protein_quantity>g, <carbohydrates_quantity>g, <fat_quantity>g"
    def to_s
        result = @name + ': '
        (@nutrient_quantities.length - 1).times do |i|
            result += "#{@nutrient_quantities[i]}g of #{@@nutrients_name[i]}, "
        end
        result += "#{@nutrient_quantities[-1]}g of #{@@nutrients_name[-1]}"
    end

    # <=> operator, defined so instances could be comparable
    # @note We consider two foods to be equal if their energetic value is the samew
    # @return [Fixnum]
    def <=>(o)
        return self.energetic_value <=> o.energetic_value
    end

    # Time interval between metrics (in minutes)
    DELTA_TIME = 5.0
      
    # Calculates the incremental area under the curve for this food given the glucose levels in blood for a person.
    # @return [Float] Area under the curve of the metrics
    # @param food_metrics [Array<Float>] Glucose in blood metrics of a person, taken each DELTA_TIME minutes for a given food
    def iauc(food_metrics)
        raise ArgumentError.new('Need at least 2 values to calculate the first trapezoid area') unless (food_metrics.length > 1)

        DELTA_TIME/2.0 * (food_metrics.drop(1).reduce(0.0, :+) + food_metrics.take(food_metrics.length - 1).reduce(0.0, :+) - 2.0 * food_metrics[0] * food_metrics.length)
    end

    # Calculates the glycemic index of a person for the given food
    # @return [Float] Glycemic index of a person for the given food
    # @param food_metrics (see #iauc)
    # @param glucose_metrics [Array<Float>] Glucose in blood metrics of a person, taken each DELTA_TIME minutes for pure glucose
    def individual_gi(food_metrics, glucose_metrics)
        raise ArgumentError.new("Sizes don't match") unless food_metrics.length == glucose_metrics.length
        
        iauc(food_metrics) / iauc(glucose_metrics) * 100.0 
    end

    # Calculates the glycemic index for the food given data of various people
    # @return [Food] Returns selfs so other methods could be chained
    # @param [Array<Hash<Symbol, Array<Float>>>] People metrics, each hash in the array is the data for a person, the hash has to have :food_metrics and :glucose_metrics keys which values are the arrays corresponding to the glucose in blood metric after the food and the pure glucose respectively.
    def gi(people_metrics)
        people_igs = []
        people_metrics.each do |person_metrics|
            people_igs << individual_gi(person_metrics[:food_metrics], person_metrics[:glucose_metrics])
        end

        @glycemic_index = people_igs.reduce(0.0, :+) / people_igs.length
        return self
    end

end
