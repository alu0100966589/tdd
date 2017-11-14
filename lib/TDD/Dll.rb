class Dll
    include Enumerable

    # Getter for the head node
    # @return [DllNode] The first node on the list or nil if there is none
    attr_reader :head

    # Getter for the tail node
    # @return [DllNode] The last node on the list or nil if there is none
    attr_reader :tail

    # Initializes to an empty list
    def initialize
        @head = nil
        @tail = nil
    end

    # Insert a new value, having it be the first on the list
    # @param value What you want to be inserted to the list
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

    # Insert a new value, having it be the last on the list
    # @param value What you want to be inserted to the list
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

    # Deletes the first element on the list
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

    # Deletes the last element on the list
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

    # Iterates over the list and yields for each item. The yield passes the value of each element to the block
    def each
        curr_node = @head
        while (curr_node != nil)
            yield curr_node.value
            curr_node = curr_node.next
        end
    end
end
