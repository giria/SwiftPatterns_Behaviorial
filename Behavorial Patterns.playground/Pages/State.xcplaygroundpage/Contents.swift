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
 
 #Example
 
 Consider the follwing ATM machine diagrram:
 
 ![UML Icon](ATM.png)
 */





import Foundation

public final class ATM {
    fileprivate var state: ATMState = IdleState()
    
    public func enter(pin: String) {
        state = EnterPINState(context: self)
        state.validate(pin: pin)
    }
    
    public func withdraw(amount: Float) -> Bool {
        return state.withdraw(amount: amount)
    }
}

fileprivate protocol ATMState {
    func validate(pin: String)
    func withdraw(amount: Float) -> Bool
    func transactionCompleted(success: Bool)
}

extension ATMState {
    func validate(pin: String) {
        print("\(#function) not implemented for \(self) state")
    }
    
    func withdraw(amount: Float) -> Bool {
        print("\(#function) not implemented for \(self) state")
        return false
    }
    
    func transactionCompleted(success: Bool) {
        print("\(#function) not implemented for \(self) state")
    }
}

fileprivate struct IdleState: ATMState {}

fileprivate struct EnterPINState: ATMState {
    var context: ATM
    
    func validate(pin: String) {
        guard pin == "1234" else {
            print("INVALID PIN")
            context.state = TransactionCompleteState(context: context)
            context.state.transactionCompleted(success: false)
            return
        }
        
        print("PIN OK")
        context.state = WithdrawState(context: context)
    }
}

fileprivate struct TransactionCompleteState: ATMState {
    var context: ATM
    
    func transactionCompleted(success: Bool) {
        var statusMessage = success ? "Transaction complete..." : "Transaction failed..."
        statusMessage += " don't forget your card!"
        print(statusMessage)
        context.state = IdleState()
    }
}

fileprivate struct WithdrawState: ATMState {
    var context: ATM
    static var availableFunds: Float = 1000
    
    func withdraw(amount: Float) -> Bool {
        print("> Withdraw $\(amount)")
        
        guard amount > 0 else {
            print("Error! Enter a valid amount")
            context.state = TransactionCompleteState(context: context)
            context.state.transactionCompleted(success: false)
            return false
        }
        
        guard WithdrawState.availableFunds >= amount else {
            print("Insufficient funds!")
            context.state = TransactionCompleteState(context: context)
            context.state.transactionCompleted(success: false)
            return false
        }
        
        WithdrawState.availableFunds -= amount
        context.state = TransactionCompleteState(context: context)
        context.state.transactionCompleted(success: true)
        return true
    }
}

// Testing
let atm = ATM()
atm.enter(pin: "1234")
atm.withdraw(amount: 5000)

//: [Next](@next)
