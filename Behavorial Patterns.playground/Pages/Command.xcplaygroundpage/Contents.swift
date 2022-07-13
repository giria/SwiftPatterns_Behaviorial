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
 
 ![UML Icon](command_2.png)
 
 
 */
import UIKit
import PlaygroundSupport

protocol Command {
    func execute()
}

struct FadeOutCommand: Command {
    fileprivate let receiver: UIView
    fileprivate let duration: TimeInterval
    
    init(receiver: UIView, duration: TimeInterval = 2.3) {
        self.receiver = receiver
        self.duration = duration
    }
    
    func execute() {
        UIView.animate(withDuration: duration) {
            self.receiver.alpha = 0
        }
    }
}

struct FadeInCommand: Command {
    fileprivate let receiver: UIView
    fileprivate let duration: TimeInterval
    
    init(receiver: UIView, duration: TimeInterval = 2.3) {
        self.receiver = receiver
        self.duration = duration
    }
    
    func execute() {
        UIView.animate(withDuration: duration) {
            self.receiver.alpha = 1
        }
    }
}

class AnimationController {
    fileprivate var command: Command?
    
    func setCommand(_ command: Command) {
        self.command = command
    }
    
    func animate() {
        command?.execute()
    }
}

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
PlaygroundPage.current.liveView = containerView

let view = UIView(frame: CGRect(x: containerView.frame.width / 2, y: containerView.frame.height / 2, width: 100, height: 100))
view.center = containerView.center
view.backgroundColor = .green

containerView.addSubview(view)

let invoker = AnimationController()

let fadeOutCommand = FadeOutCommand(receiver: view, duration: 2)

invoker.setCommand(fadeOutCommand)

let delay = 2
DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
    
    invoker.animate()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: {
        let fadeInCommand = FadeInCommand(receiver: view, duration: 2)
        invoker.setCommand(fadeInCommand)
        
        invoker.animate()
    })
}


//: [Next](@next)
