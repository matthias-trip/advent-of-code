import XCTest

@testable import AdventOfCode

// One off test to validate that basic data load testing works
final class AdventChallengeTests: XCTestCase {
  func testInitData() throws {
    let challenge = Day00_2024()
    XCTAssertTrue(challenge.data.starts(with: "4514"))
  }
}
