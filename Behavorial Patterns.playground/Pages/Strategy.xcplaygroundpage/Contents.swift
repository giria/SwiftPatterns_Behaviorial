//: [Previous](@previous)
/*:
 
 # Strategy
 
 Enables selecting an algorithm at runtime.Instead of implementing a single algorithm directly, code receives run-time instructions as to which in a family of algorithms to use.
 
 ![UML Icon](strategy.png)
 
 In the above UML class diagram, the Context class doesn't implement an algorithm directly. Instead, Context refers to the Strategy interface for performing an algorithm (strategy.algorithm()), which makes Context independent of how an algorithm is implemented. The Strategy1 and Strategy2 classes implement the Strategy interface, that is, implement (encapsulate) an algorithm.
 The UML sequence diagram shows the run-time interactions: The Context object delegates an algorithm to different Strategy objects. First, Context calls algorithm() on a Strategy1 object, which performs the algorithm and returns the result to Context. Thereafter, Context changes its strategy and calls algorithm() on a Strategy2 object, which performs the algorithm and returns the result to Context.
 
 
 */



import Foundation

protocol LogStrategy {
    func log(entry: String)
    func retrieveLogs() -> [String]?
}

final class LoggerContext {
    private var strategy: LogStrategy
    private var logQueue = DispatchQueue(label: "ConsoleLogQueue")
    
    init(strategy: LogStrategy) {
        self.strategy = strategy
    }
    
    func write(entry: String) {
        logQueue.sync {
            strategy.log(entry: entry)
        }
    }
    
    var logs: [String]? {
        var result: [String]? = nil
        logQueue.sync {
            result = strategy.retrieveLogs()
        }
        return result
    }
}

class ConsoleLogStrategy: LogStrategy {
    func log(entry: String) {
        print(entry)
    }
    
    func retrieveLogs() -> [String]? {
        return nil
    }
}

class InMemoryLogStrategy: LogStrategy {
    private var logEntries = [String]()
    
    func log(entry: String) {
        logEntries.append(entry)
    }
    
    func retrieveLogs() -> [String]? {
        return logEntries
    }
}




// Test it with the console or inMemory logger

 let logger = LoggerContext(strategy: ConsoleLogStrategy())
//let logger = LoggerContext(strategy: InMemoryLogStrategy())
logger.write(entry: "Strategy pattern demo")
logger.write(entry: "Cool, isn't it?")

logger.logs?.forEach{ print($0) }

//: [Next](@next)
