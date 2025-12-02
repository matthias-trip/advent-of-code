import Foundation

import Algorithms

struct Day09_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    
    let sequences: [[Int]]
    
    init(data: String) {
        self.data = data
        self.sequences = self.data.components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { $0.components(separatedBy: " ").compactMap { Int($0) } }
    }
    
    func part1() -> Any {
        return self.sequences.map { findNext(in: $0) }
            .reduce(0, +)
    }
    
    func part2() -> Any {
        return self.sequences.map { findPrevious(in: $0) }
            .reduce(0, +)
    }
    
    private func findNext(in sequence: [Int]) -> Int {
        let deltas = self.getDeltas(for: sequence)
        let last = (0..<deltas.count).reduce(0) { $0 + deltas[$1].last! }
        return sequence.last! + last
    }
    
    private func findPrevious(in sequence: [Int]) -> Int {
        let deltas = self.getDeltas(for: sequence)
        let first = (0..<deltas.count)
            .reversed()
            .reduce(0) { deltas[$1].first! - $0 }
        return sequence.first! - first
    }
    
    private func getDeltas(for sequence: [Int]) -> [[Int]] {
        var deltas = [[Int]]()
        var seq = sequence
        while true {
            let delta = seq.enumerated()
                .dropFirst()
                .map { $0.element - seq[$0.offset - 1] }
            deltas.append(delta)
            if delta.allSatisfy({ $0 == 0 }) {
                break
            }
            seq = delta
        }
        return deltas
    }
}
