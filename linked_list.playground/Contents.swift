import Foundation
/*
 step 1 — create a Node class
 step 2 — create a LinkedList class
 step 3 — provide a last Node
 step 4 — add the ability to append Nodes
 step 5 — fetch the number Nodes in a LinkedList
 step 6 — print each Node value from a LinkedList
 step 7 — fetch a Node from a specified index
 step 8 — insert a Node at a specific index
 step 9 — remove a Node at a specific index
 */
public class Node<T> {
    var value: T
    var next: Node?
    weak var previous: Node?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    private var head: Node<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }

        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public var print: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
    
    public func node(atIndex index: Int) -> Node<T> {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { //(*1)
                    break
                }
            }
            return node!
        }
    }
    
    public func remove(node: Node<T>) -> T {
        let previousNode = node.previous
        let nextNode = node.next
        
        if let previousNode = previousNode {
            previousNode.next = nextNode
        } else {
            head = nextNode
        }
        nextNode?.previous = previousNode
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func removeAt(_ index: Int) -> T {
        let nodeToRemove = node(atIndex: index)
        return remove(node: nodeToRemove)
    }
}

var list = LinkedList<Int>()
list.append(value: 11)
list.append(value: 7)
list.append(value: 23)
list.append(value: 44)
list.append(value: 35)
list.append(value: 62)

print("link List = \(list.print)")

let node = list.node(atIndex: 5)
print("Value at 5th index = \(node.value)")

print("Count = \(list.count)")

let removedNode = list.removeAt(4)
print("removed Value at index 4 = \(removedNode)")

print("link List = \(list.print)")

let firstValue = list.first?.value
print("link List Head Value = \(String(describing: firstValue ?? 0))")

let lastValue = list.last?.value
print("link List Tail Value = \(String(describing: lastValue ?? 0))")

