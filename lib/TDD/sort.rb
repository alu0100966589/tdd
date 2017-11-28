# Open the Array class
class Array

     # Returns the array sorted
     # @return [Array] the array sorted
     def sort_for
          # Deep copy
          r = Marshal.load(Marshal.dump(self))
          for i in (0...r.length)
               for j in (0...(r.length-i-1))
                    r[j], r[j+1] = r[j+1], r[j] if(r[j] > r[j+1])
               end
          end

          return r
     end

     # Returns the array sorted
     # @return [Array] the array sorted
     def sort_each
          # Deep copy
          aux = Marshal.load(Marshal.dump(self))
          result = []

          # Each iteration finds the minimun from aux,
          # deletes it and add it to result
          self.length.times do |i|
               m = aux.each_with_index.min
               aux.delete_at(m[1])
               result << m[0]
          end
          
          return result
     end
end