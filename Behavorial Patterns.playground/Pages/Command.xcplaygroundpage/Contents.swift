//: [Previous](@previous)

/*:
 
 # Command
 
 Encapsulates method invocation in an object.
 
 ## What problems can the Interpreter design pattern solve?
 - Coupling the invoker of a request to a particular request should be avoided. That is, hard-wired requests should be avoided.
 - It should be possible to configure an object (that invokes a request) with a request.
 
 
 ![UML Icon](command.png)
 
 In the above UML class diagram, the Invoker class doesn't implement a request directly. Instead, Invoker refers to the Command interface to perform a request (command.execute()), which makes the Invoker independent of how the request is performed. The Command1 class implements the Command interface by performing an action on a receiver (receiver1.action1()).

 The UML sequence diagram shows the run-time interactions: The Invoker object calls execute() on a Command1 object. Command1 calls action1() on a Receiver1 object, which performs the request.
 
 */
import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
