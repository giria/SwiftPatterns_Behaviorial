//: [Previous](@previous)


/*:
 
 # Chain of responsbility
 
 Organizers potential request processors in a sequence and decouples responders from callers.
 
 ## What problems can the Chain of responsability  design pattern solve?
 - Coupling the sender of a request to its receiver should be avoided.
 - It should be possible that more than one receiver can handle a request.
 
 ![UML Icon](chain.png)
 
 In the above UML class diagram, the Sender class doesn't refer to a particular receiver class directly. Instead, Sender refers to the Handler interface for handling a request (handler.handleRequest()), which makes the Sender independent of which receiver handles the request. The Receiver1, Receiver2, and Receiver3 classes implement the Handler interface by either handling or forwarding a request (depending on run-time conditions).
 The UML sequence diagram shows the run-time interactions: In this example, the Sender object calls handleRequest() on the receiver1 object (of type Handler). The receiver1 forwards the request to receiver2, which in turn forwards the request to receiver3, which handles (performs) the request.
 
 */
import Foundation

public protocol Message {
    var name: String {get}
}

public protocol MessageProcessing {
    init(next: MessageProcessing?)
    func process(message: Message)
    
    var messageIDs: [String]? {get}
    var next: MessageProcessing? {get}
}

extension MessageProcessing {
    public func process(message: Message) {
        if let shouldProcess = messageIDs?.contains(where: { $0 == message.name }),
            shouldProcess == true {
            print("Message processed by \(self)\n")
        } else {
            if let next = next {
                print("\(self) could not process message \(message.name)")
                print("\t Forwarding to \(next)")
                next.process(message: message)
            } else {
                print("Next responder not set. Reached the end of the responder chain\n")
            }
        }
    }
}

public struct ResponseMessage: Message {
    public var name: String
}

public struct XMLProcessor: MessageProcessing, CustomStringConvertible {
    public var next: MessageProcessing? {
        return nextProcessor
    }

    fileprivate var nextProcessor: MessageProcessing?
    
    public var messageIDs: [String]? {
        return ["XML"]
    }
    
    public init(next: MessageProcessing?) {
        nextProcessor = next
    }
    
// Extracted to protocol extension
    
//    public func process(message: Message) {
//        if let shouldProcess = messageIDs?.contains(where: { $0 == message.name }),
//            shouldProcess == true {
//            print("Message processed by \(self)\n")
//        } else {
//            if let next = nextProcessor {
//                print("\(self) could not process message \(message.name)")
//                print("\t Forwarding to \(next)")
//                next.process(message: message)
//            } else {
//                print("Next responder not set. Reached the end of the responder chain\n")
//            }
//        }
//    }
    
    public var description: String {
        return "XMLProcessor"
    }
}


public struct JSONProcessor: MessageProcessing, CustomStringConvertible {
    public var next: MessageProcessing? {
        return nextProcessor
    }

    fileprivate var nextProcessor: MessageProcessing?
    
    public var messageIDs: [String]? {
        return ["JSON"]
    }
    
    public init(next: MessageProcessing?) {
        nextProcessor = next
    }
    
// Extracted to protocol extension
    
//    public func process(message: Message) {
//        if let shouldProcess = messageIDs?.contains(where: { $0 == message.name }),
//            shouldProcess == true {
//            print("Message processed by \(self)\n")
//        } else {
//            if let next = nextProcessor {
//                print("\(self) could not process request \(message.name)")
//                print("\t Forwarding to \(next)")
//                next.process(message: message)
//            } else {
//                print("Next responder not set. Reached the end of the responder chain\n")
//            }
//        }
//    }
    
    public var description: String {
        return "JSONProcessor"
    }
}


public struct ResponderChainEnd: MessageProcessing {
    public var next: MessageProcessing? = nil

    public var messageIDs: [String]? {
        return nil
    }
    
    public init(next: MessageProcessing?) {
        //
    }
    
    public func process(message: Message) {
        print("Reached the end of the responder chain\n")
    }
}

// Testing
let message = ResponseMessage(name: "Test")

let responderChainEnd = ResponderChainEnd(next: nil)
let jsonProcessor = JSONProcessor(next: responderChainEnd)
let xmlProcessor = XMLProcessor(next: jsonProcessor)

xmlProcessor.process(message: message)


let xmlMessage = ResponseMessage(name: "XML")
xmlProcessor.process(message: xmlMessage)

let jsonMessage = ResponseMessage(name: "JSON")
xmlProcessor.process(message: jsonMessage)


//: [Next](@next)
