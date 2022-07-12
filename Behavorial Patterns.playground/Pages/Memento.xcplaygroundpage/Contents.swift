//: [Previous](@previous)



/*:
 # Memento
 
 Can be used to restore the state of an object to a previous state.
 
 
 ## What problems can the Memento design pattern solve?
 
 - The internal state of an object should be saved externally so that the object can be restored to this state later.
 - The object's encapsulation must not be violated.
 
 
 ![UML Icon](memento.png)
 
 In the above UML class diagram, the Caretaker class refers to the Originator class for saving (createMemento()) and restoring (restore(memento)) originator's internal state.
 The Originator class implements
 (1) createMemento() by creating and returning a Memento object that stores originator's current internal state and
 (2) restore(memento) by restoring state from the passed in Memento object.

 The UML sequence diagram shows the run-time interactions:
 (1) Saving originator's internal state: The Caretaker object calls createMemento() on the Originator object, which creates a Memento object, saves its current internal state (setState()), and returns the Memento to the Caretaker.
 (2) Restoring originator's internal state: The Caretaker calls restore(memento) on the Originator object and specifies the Memento object that stores the state that should be restored. The Originator gets the state (getState()) from the Memento to set its own state.
 
 */


import Foundation
import PlaygroundSupport

// GameScene
public final class GameScene {
    private var score: UInt
    private var progress: Float
    private var sessionTime: TimeInterval
    
    lazy private var sessionTimer = Timer.init(timeInterval: 1, repeats: true) { (timer) in
        self.sessionTime += timer.timeInterval
    }
    
    public init() {
        self.score = 0
        self.progress = 0
        self.sessionTime = 0
    }
    
    public func start() {
        RunLoop.current.add(sessionTimer, forMode: RunLoop.Mode.default) 
        sessionTimer.fire()
    }
    
    public var levelScore: UInt {
        get {
            return score
        }
        set {
            score = newValue
        }
    }
    
    public var levelProgress: Float {
        get {
            return progress
        }
        set {
            progress = newValue <= 100 ? newValue : 100
        }
    }
}

extension GameScene: CustomStringConvertible {
    public var description: String {
        return "Level progress \(progress), player score: \(score). Play time \(sessionTime) seconds"
    }
}


protocol Memento {
    associatedtype State
    var state: State { get set }
}

protocol Originator {
    associatedtype M: Memento
    func createMemento() -> M
    mutating func apply(memento: M)
}

protocol Caretaker {
    associatedtype O: Originator
    func saveState(originator: O, identifier: AnyHashable)
    func restoreState(originator: O, identifier: AnyHashable)
}

struct GameMemento: Memento {
    var state: ExternalGameState
}

struct ExternalGameState {
    var playerScore: UInt
    var levelProgress: Float
}

extension GameScene: Originator {
    func createMemento() -> GameMemento {
        let currentState = ExternalGameState(playerScore: score, levelProgress: progress)
        return GameMemento(state: currentState)
    }
    
    func apply(memento: GameMemento) {
        let restoreState = memento.state
        score = restoreState.playerScore
        progress = restoreState.levelProgress
    }
}

public final class GameSceneManager: Caretaker {
    private lazy var snapshots = [AnyHashable: GameMemento]()
    
    public func saveState(originator: GameScene, identifier: AnyHashable) {
        let snapshot = originator.createMemento()
        snapshots[identifier] = snapshot
    }
    
    public func restoreState(originator: GameScene, identifier: AnyHashable) {
        if let snapshot = snapshots[identifier] {
            originator.apply(memento: snapshot)
        }
    }
    
    public init() {}
}

let gameScene = GameScene()
gameScene.start()

let sceneManager = GameSceneManager()
sceneManager.saveState(originator: gameScene, identifier: "initial")
print(gameScene)

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
    gameScene.levelProgress = 55
    gameScene.levelScore = 2500
    
    sceneManager.saveState(originator: gameScene, identifier: "snapshot_1")
    print(gameScene)
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
        gameScene.levelProgress = 80
        gameScene.levelScore = 10000
        
        sceneManager.saveState(originator: gameScene, identifier: "snapshot_2")
        print(gameScene)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            sceneManager.restoreState(originator: gameScene, identifier: "initial")
            print("\nRestoring \"initial\"")
            print(gameScene)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                sceneManager.restoreState(originator: gameScene, identifier: "snapshot_2")
                print("\nRestoring \"snapshot_2\"")
                print(gameScene)
                
                PlaygroundPage.current.finishExecution()
            })
        })
    })
}

PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
