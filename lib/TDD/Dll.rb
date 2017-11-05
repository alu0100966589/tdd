class Dll
    attr_reader :head, :tail
    def initialize
        @head = nil
        @tail = nil
    end

    def insert_head(value)
        if( @head == nil )
            @head = DllNode.new( nil, value, nil )
            @tail = @head
        else
           aux = DllNode.new( nil, value, @head ) 
           @head.prev = aux
           @head = aux
        end
    end

    def insert_tail(value)
        if( @tail == nil )
            @head = DllNode.new( nil, value, nil )
            @tail = @head
        else
           aux = DllNode.new( @tail, value, nil ) 
           @tail.next = aux
           @tail = aux
        end
    end

    def extract_head
        if( @head != nil )
            if( @head.next == nil )
                @head = nil
                @tail = nil
            else
                @head = @head.next
                @head.prev.next = nil
                @head.prev = nil
            end
        end
    end
    def extract_tail
        if( @tail != nil )
            if( @tail.prev == nil)
                @tail = nil
                @head = nil
            else
                @tail = @tail.prev
                @tail.next.prev = nil
                @tail.next = nil
            end
        end
    end
end
