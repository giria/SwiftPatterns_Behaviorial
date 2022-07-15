//: [Previous](@previous)
//: [Next](@next)
/*:
 
 # Observer
 
 Broadcast notifications to observers.
 
 ##  What problems can the Observer design pattern solve?
 
 The Observer pattern addresses the following problems:[2]

 - A one-to-many dependency between objects should be defined without making the objects tightly coupled.
 - It should be ensured that when one object changes state, an open-ended number of dependent objects are updated automatically.
 - It should be possible that one object can notify an open-ended number of other objects.
 
 ![UML Icon](observer.png)
 
 In the above UML class diagram, the Subject class does not update the state of dependent objects directly. Instead, Subject refers to the Observer interface (update()) for updating state, which makes the Subject independent of how the state of dependent objects is updated. The Observer1 and Observer2 classes implement the Observer interface by synchronizing their state with subject's state.

 The UML sequence diagram shows the run-time interactions: The Observer1 and Observer2 objects call attach(this) on Subject1 to register themselves. Assuming that the state of Subject1 changes, Subject1 calls notify() on itself.
 notify() calls update() on the registered Observer1 and Observer2 objects, which request the changed data (getState()) from Subject1 to update (synchronize) their state.
 
 
 
 */









import Foundation
struct Bidder {
    var id: String
    init(id: String) {
        self.id = id
        NotificationCenter.default.addObserver(forName: NSNotification.Name(BidNotificationNames.bidNotification), object: nil, queue: nil) { (notification) in
            if let userInfo = notification.userInfo,
                let bidValue = userInfo["bid"] as? Float,
                let message = userInfo["message"] as? String {
                print("\t\(id) new bid is \(bidValue) \(message)")
            }
        }
    }
}

struct BidNotificationNames {
    static let bidNotification = "bidNotification"
}

struct BidNotification {
    var bid: Float
    var message: String?
}

struct Auctioneer {
    private var bidders = [Bidder]()

    private var auctionEnded: Bool = false
    private var currentBid: Float = 0
    private var reservePrice: Float = 0
    
    var bid: Float {
        set {
            if auctionEnded {
                print("\nAuction ended. We don't accept new bids")
            } else if newValue > currentBid {
                print("\nNew bid $\(newValue) accepted")
                if newValue >= reservePrice {
                    print("Reserve price met! Auction ended.")
                    auctionEnded = true
                }
                currentBid = newValue
                
                let message = bid > reservePrice ? "Reserve met, item sold" : ""
                let notification = Notification(name: Notification.Name(BidNotificationNames.bidNotification), object: nil, userInfo: ["bid": bid, "message": message])
                NotificationCenter.default.post(notification)
            }
        }
        get {
            return currentBid
        }
    }
    
    init(initialBid: Float = 0, reservePrice: Float) {
        self.bid = initialBid
        self.reservePrice = reservePrice
    }
}


// Test
var auctioneer = Auctioneer(reservePrice: 500)

let bidder1 = Bidder(id: "Joe")
let bidder2 = Bidder(id: "Quinn")
let bidder3 = Bidder(id: "Sal")
let bidder4 = Bidder(id: "Murr")

auctioneer.bid = 100
auctioneer.bid = 150

//auctioneer.detach(observer: bidder1)
auctioneer.bid = 300
auctioneer.bid = 550
//: [Next](@next)
