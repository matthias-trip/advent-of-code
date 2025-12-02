import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {

    private struct RankTestCase {
        let hand: String
        let expectedRank: Day07_2024.Rank
    }

    let testHand = "32T3K 765"

    func test_hand_rank_fiveOfAKind() {
        let testCases: [RankTestCase] = [
            .init(hand: "AAAAA 100", expectedRank: .fiveOfaKind),
            .init(hand: "AA8AA 100", expectedRank: .fourOfaKind),
            .init(hand: "23332 100", expectedRank: .fullHouse),
            .init(hand: "TTT98 100", expectedRank: .threeOfAKind),
            .init(hand: "23432 100", expectedRank: .twoPair),
            .init(hand: "A23A4 100", expectedRank: .onePair),
            .init(hand: "23456 100", expectedRank: .highCard)
        ]

        for testCase in testCases {
            // When
            let parsedHand = Day07_2024.Hand(from: testCase.hand)

            // Then
            XCTAssertEqual(parsedHand.rank, testCase.expectedRank)
        }
    }
}
