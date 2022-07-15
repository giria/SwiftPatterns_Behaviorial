//: [Previous](@previous)
//: [Next](@next)

/*:
 
 # Mediator
  Simplifies the comunication between objects. It does so introducing a middelman (mediator).
 
 ## What problems can the Mediator design pattern solve?
 
 - Tight coupling between a set of interacting objects should be avoided.
 - It should be possible to change the interaction between a set of objects independently.
 
 ![UML Icon](mediator.png)
 
 In the above UML class diagram, the Colleague1 and Colleague2 classes do not refer to (and update) each other directly. Instead, they refer to the common Mediator interface for controlling and coordinating interaction (mediate()), which makes them independent from one another with respect to how the interaction is carried out. The Mediator1 class implements the interaction between Colleague1 and Colleague2.

 The UML sequence diagram shows the run-time interactions. In this example, a Mediator1 object mediates (controls and coordinates) the interaction between Colleague1 and Colleague2 objects.

 Assuming that Colleague1 wants to interact with Colleague2 (to update/synchronize its state, for example), Colleague1 calls mediate(this) on the Mediator1 object, which gets the changed data from Colleague1 and performs an action2() on Colleague2.

 Thereafter, Colleague2 calls mediate(this) on the Mediator1 object, which gets the changed data from Colleague2 and performs an action1() on Colleague1.
 
 */



import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
