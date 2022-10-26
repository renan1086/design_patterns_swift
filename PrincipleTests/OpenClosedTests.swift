import XCTest
@testable import Principle

final class OpenClosedTests: XCTestCase {

    var products : [Product]!
    
    override func setUp() {
        let apple = Product("Apple", .green, .small)
        let tree = Product("Tree", .green, .large)
        let house = Product("House", .blue, .large)
        
        products = [apple, tree, house]
    }
    
    override func tearDown() {
        products = nil
    }
    
    func testFilterColor() throws {
        let betterFilter = BetterFilter()
        let result = betterFilter.filter(products, ColorSpecification.init(color: .green))
        XCTAssertEqual(result.count, 2)
        XCTAssertNotNil(result.filter {$0.name == "Apple"})
        XCTAssertNotNil(result.filter {$0.name == "Tree"})
    }
    
    func testFilterSize() throws {
        let betterFilter = BetterFilter()
        let result = betterFilter.filter(products, SizeSpecification(size: .large))
        XCTAssertEqual(result.count, 2)
        XCTAssertNotNil(result.filter {$0.name == "House"})
        XCTAssertNotNil(result.filter {$0.name == "Tree"})
    }
    
    func testFilterSizeAndColor() throws {
        let betterFilter = BetterFilter()
        let result = betterFilter.filter(products, AndSpecification(first: ColorSpecification(color: .green), second: SizeSpecification(size: .large)))
        XCTAssertEqual(result.count, 1)
        XCTAssertNotNil(result.filter {$0.name == "Tree"})
    }
}
