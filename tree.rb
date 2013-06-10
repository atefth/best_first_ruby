class Tree

    # mixin 'Debug module'
    include Debug

    # class constants
    ROOT = 0
    DEPTH = 1
    WIDTH = 0

    attr_reader :nodes

    def initialize ()
        @nodes = Array.new
    end

    # ============================================================

    private

    def updateFPointer(pos, id, mode)
        if pos.nil?
            return
        else
            @nodes[pos].updateFPointer(id, mode)
        end
    end

    def updateBPointer(pos, id)
        @nodes[pos].bpointer = id
    end

    def generateId
        result = 0
        @nodes.each do | node |
            if node.id > result
                result = node.id
            end
        end
        result += 1
        return result
    end

    def getIndex(pos = nil)
        if pos.nil?
            return ROOT
        else
            index = 0
            @nodes.each do | node |
                break if node.id == pos
                index += 1
            end
        end
        return index
    end

    # ============================================================

    public

    def appendNode(pos, name)
        if pos.nil?
            id = ROOT
        else
            id = generateId
        end
        node = Node.new(id, name)
        @nodes.push(node)
        updateFPointer(pos, id, ::ADD)
        node.bpointer = pos
        return node
    end

    def insertNode(pos, name)
        # stub
    end

    def deleteNode(pos)
        # stub
    end

    def show(pos = ROOT, level = ROOT)
        queue = @nodes[pos].fpointer
        if !queue.empty? # branch
            if level == ROOT
                puts "#{@nodes[pos].id}: #{@nodes[pos].name}"
            else
                puts "t"*level + "#{@nodes[pos].id}: #{@nodes[pos].name}"
            end
            if @nodes[pos].expanded
                level += 1
                queue.each do | element |
                    show(element, level) # recursive call
                end
            end
        else # leaf
            if level == ROOT
                puts "#{@nodes[pos].id}: #{@nodes[pos].name}"
            else
                puts "t"*level + "#{@nodes[pos].id}: #{@nodes[pos].name}"
            end
        end
    end

    # iterator method
    # Loosly based on an algorithm from 'Essential LISP' by
    # John R. Anderson, Albert T. Corbett, and Brian J. Reiser, page 239-241
    def expandDown(pos = ROOT, mode = DEPTH)
        yield pos
        queue = @nodes[pos].fpointer
        while !queue.empty?
            yield queue[0]
            expand = @nodes[queue[0]].fpointer
            if mode == DEPTH
                queue = expand + queue.slice(1, queue.length) # depth-first
            else
                queue = queue.slice(1, queue.length) + expand # width-first
            end
        end
    end

    # debug statement
    def list
        @nodes.each { | node | puts node.whoAmI? }
    end

    # array-like accessors
    def [](key)
        @nodes[getIndex(key)]
    end

    def []=(key, item)
        @nodes[getIndex(key)] = item
    end

    # converter functions
    def to_s
        # stub
    end

    def to_xml
        # stub
    end
end