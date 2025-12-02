import XCTest

@testable import AdventOfCode

final class Day04Tests: XCTestCase {
    let testData = "Card 1: 41  8 83 86 17 | 83 86  6 31 17  9 48 53"

    func test_card_winningNumbers() {
        // Given
        let expectedWinningNumbers: Set<Int> = [41, 8, 83, 86, 17]

        // When
        let sut = Card_2024(from: self.testData)

        // Then
        XCTAssertEqual(sut.winnningNumbers, expectedWinningNumbers)
    }

    func test_card_myNumbers() {
        // Given
        let expectedMyNumbers: Set<Int> = [83, 86, 6, 31, 17, 9, 48, 53]

        // When
        let sut = Card_2024(from: self.testData)

        // Then
        XCTAssertEqual(sut.myNumbers, expectedMyNumbers)
    }
}
