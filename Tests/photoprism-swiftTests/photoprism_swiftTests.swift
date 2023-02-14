import XCTest
@testable import photoprism_swift

final class photoprism_swiftTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let prism = photoprism_swift()
        XCTAssertEqual(prism.text, "Hello, World!")
    }
}
