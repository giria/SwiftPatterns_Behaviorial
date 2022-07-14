//: [Previous](@previous)

/*:
 # Visitor Pattern
 
   Adds common behaviour to unrelate types.
 
 ## What problems can the Visitor design pattern solve?
 
 - It should be possible to define a new operation for (some) classes of an object structure without changing the classes.
 
 ## What solution does the Visitor design pattern describe?
 
 - Define a separate (visitor) object that implements an operation to be performed on elements of an object structure.
 - Clients traverse the object structure and call a dispatching operation accept (visitor) on an element — that "dispatches" (delegates) the request to the "accepted visitor object". The visitor object then performs the operation on the element ("visits the element").
 This makes it possible to create new operations independently from the classes of an object structure by adding new visitor objects.

 See also the UML class and sequence diagram below.
 
![UML Icon](visitor.png)
 
 In the UML class diagram above, the `ElementA` class doesn't implement a new operation directly. Instead, ElementA implements a dispatching operation accept(visitor) that "dispatches" (delegates) a request to the "accepted visitor object" (visitor.visitElementA(this)). The Visitor1 class implements the operation (visitElementA(e:ElementA)).
 ElementB then implements accept(visitor) by dispatching to visitor.visitElementB(this). The Visitor1 class implements the operation (visitElementB(e:ElementB)).

 The UML sequence diagram shows the run-time interactions: The Client object traverses the elements of an object structure (ElementA,ElementB) and calls accept(visitor) on each element.
 First, the Client calls accept(visitor) on ElementA, which calls visitElementA(this) on the accepted visitor object. The element itself (this) is passed to the visitor so that it can "visit" ElementA (call operationA()).
 Thereafter, the Client calls accept(visitor) on ElementB, which calls visitElementB(this) on the visitor that "visits" ElementB (calls operationB()).
 
 
*/
import Foundation

protocol CommonAttributes {
    var price: Float { get }
}

struct Book {
    var isbn: String
    var title: String
    var itemPrice: Float
}

extension Book: CommonAttributes {
    var price: Float {
        return itemPrice
    }
}

struct Computer {
    var serialNumber: String
    var brand: String
    var unitPrice: Float
}

extension Computer: CommonAttributes {
    var price: Float {
        return unitPrice
    }
}

struct Car {
    var ean: String
    var make: String
    var model: String
    var stickerPrice: Float
}

extension Car: CommonAttributes {
    var price: Float {
        return stickerPrice
    }
}

let book = Book(isbn: "178-4-19-155607-0", title: "Swift Design Patterns", itemPrice: 30)
let macBook = Computer(serialNumber: "12345-00", brand: "Apple MacBook Pro", unitPrice: 2500)
let teslaS = Car(ean: "1KL4KXBG0AF148193", make: "Tesla", model: "S", stickerPrice: 69200)

var shoppingCart = [CommonAttributes]()
shoppingCart.append(contentsOf: [book, macBook, teslaS] as [CommonAttributes])


func calculateTotalPrice(items: [CommonAttributes]) -> Float {
    var price: Float = 0
    for item in items {
        price += item.price
    }
    return price
}

print(calculateTotalPrice(items: shoppingCart))
//: [Next](@next)

