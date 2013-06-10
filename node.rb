class Node

    # mixin 'Debug module'
    include Debug

    attr_accessor :id
    attr_accessor :name
    attr_accessor :bpointer
    attr_accessor :expanded
    attr_reader :fpointer

    def initialize(id, name)
        @id = id
        @name = name
        @bpointer = nil
        @fpointer = Array.new
        @expanded = true
    end

    def to_s()
        "Id[#{self.id}]: #{self.name}"
    end

    def to_xml
        # stub
    end

    def updateFPointer(id, mode, fpointer = nil)
        if fpointer.nil?
            case mode
            when ::ADD then @fpointer.push(id)
            when ::DELETE then @fpointer.delete(id)
            when ::INSERT then @fpointer = [id]
            end
        else
            @fpointer = fpointer
        end
    end
end