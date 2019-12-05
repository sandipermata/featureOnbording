import XCTest
@testable import featureOnbording

final class featureOnbordingTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(featureOnbording().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
