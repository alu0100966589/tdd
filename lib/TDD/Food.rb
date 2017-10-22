class Food
    @@nutrients_name = ["proteins", "carbohydrates", "fats"]

    def self.nutrients_name
        @@nutrients_name
    end

    attr_reader :name

    def initialize( name )
        @name = name
    end
end
