# Open the Array class
class Array

     # Returns the array sorted
     # @return [Array] an array sorted using for loops
     def sort_for
          # Deep copy
          r = Marshal.load(Marshal.dump(self))
          for i in (0...r.length)
               for j in ((i+1)...r.length)
                    r[i], r[j] = r[j], r[i] if(r[i] > r[j])
               end
          end

          return r
     end
end