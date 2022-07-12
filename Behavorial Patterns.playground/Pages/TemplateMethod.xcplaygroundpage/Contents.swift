//: [Previous](@previous)
/*:
 
 # Template Method
   Allows specific steps of an algorith to be replaced by the client without modifying the structure of the algorithm.
 
 ## What problems can the Template Method design pattern solve?
 
 The template method is a method in a superclass, usually an abstract superclass, and defines the skeleton of an operation in terms of a number of high-level steps. These steps are themselves implemented by additional helper methods in the same class as the template method.

 The helper methods may be either abstract methods, in which case subclasses are required to provide concrete implementations, or hook methods, which have empty bodies in the superclass. Subclasses can (but are not required to) customize the operation by overriding the hook methods. The intent of the template method is to define the overall structure of the operation, while allowing subclasses to refine, or redefine, certain steps.
 
 
 
 
 
 
 */

typealias File     = String
typealias RawData  = String
typealias `Data`   = String
typealias Analysis = String
/// Blueprint of the functions that will require custom implementations
protocol DataMiner {
    func openFile(path: String) -> File
    func extractData(file: File) -> RawData
    func parseData(data: RawData) -> `Data`
    func closeFile(file: File)
}
extension DataMiner {
    /// TEMPLATE METHOD: series of functions defining the algorithm
    func mine(path: String) {
        let file = openFile(path: path)
        let rawData = extractData(file: file)
        let data = parseData(data: rawData)
        let analysis = analyzeData(analysis: data)
        sendReport(analysis: analysis)
        closeFile(file: file)
    }
    // MARK: Default implementations
    func analyzeData(analysis: `Data`) -> Analysis {
        print("ℹ️ analyze data")
        return "analysis"
    }
    func sendReport(analysis: Analysis) {
        print("ℹ️ send report")
    }
}
// PDFDataMiner conforms to the DataMiner protocol
class PDFDataMiner: DataMiner {
    init() {
        // Call the template method
        mine(path: "PDFFilePath")
    }
    func openFile(path: String) -> File {
        print("📃️ open PDF File")
        return "PDF file opened"
    }
    func extractData(file: File) -> RawData {
        print("📃️ extract PDF data")
        return "PDF raw data extracted"
    }
    func parseData(data: RawData) -> `Data` {
        print("📃️ parse PDF data")
        return "PDF data parsed"
    }
    func closeFile(file: File) {
        print("📃️ close PDF File")
    }
}
// Testing the PDF implementation
_ = PDFDataMiner()
//: [Next](@next)
