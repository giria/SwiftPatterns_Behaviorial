//: [Previous](@previous)
/*:
 # Iterator
 
 Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
 
 ## What problems can the Iterator design pattern solve?
 
 - The elements of an aggregate object should be accessed and traversed without exposing its representation (data structures).
 - New traversal operations should be defined for an aggregate object without changing its interface.
 
 
 ![UML Icon](iterator.png)
 
 In the above UML class diagram, the Client class refers (1) to the Aggregate interface for creating an Iterator object (createIterator()) and (2) to the Iterator interface for traversing an Aggregate object (next(),hasNext()). The Iterator1 class implements the Iterator interface by accessing the Aggregate1 class.

 The UML sequence diagram shows the run-time interactions: The Client object calls createIterator() on an Aggregate1 object, which creates an Iterator1 object and returns it to the Client. The Client uses then Iterator1 to traverse the elements of the Aggregate1 object.
 */
import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
