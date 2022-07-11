//: [Previous](@previous)

/*:
 
 #State
 
 Allows an object to alter its behavior when its internal state changes.
 
 ##  What problems can the State design pattern solve?
 
 This pattern is close to the concept of finite-state machines. The state pattern can be interpreted as a strategy pattern, which is able to switch a strategy through invocations of methods defined in the pattern's interface.

 The state pattern is used in computer programming to encapsulate varying behavior for the same object, based on its internal state. This can be a cleaner way for an object to change its behavior at runtime without resorting to conditional statements and thus improve maintainability.
 
 
 ![UML Icon](state.png)
 
 In the above Unified Modeling Language (UML) class diagram, the Context class doesn't implement state-specific behavior directly. Instead, Context refers to the State interface for performing state-specific behavior (state.handle()), which makes Context independent of how state-specific behavior is implemented. The ConcreteStateA and ConcreteStateB classes implement the State interface, that is, implement (encapsulate) the state-specific behavior for each state. The UML sequence diagram shows the run-time interactions:
 
 ![UML Icon](sequence_diagram.png)

 The Context object delegates state-specific behavior to different State objects. First, Context calls handle(this) on its current (initial) state object (ConcreteStateA), which performs the operation and calls setState(ConcreteStateB) on Context to change context's current state to ConcreteStateB. The next time, Context again calls handle(this) on its current state object (ConcreteStateB), which performs the operation and changes context's current state to ConcreteStateA.
 
 
 */





import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
