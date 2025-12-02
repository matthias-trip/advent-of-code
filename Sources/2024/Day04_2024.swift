import Algorithms
import Foundation

struct Card_2024 {
    let id: Int
    let winnningNumbers: Set<Int>
    let myNumbers: Set<Int>
    
    init(from line: String) {
        let parts = line.dropFirst(8).components(separatedBy: " | ")
 
        self.id = Int(line.prefix(8).filter { "0"..."9" ~= $0 })!
        self.winnningNumbers = Set(parts.first!.components(separatedBy: " ").compactMap { Int($0) })
        self.myNumbers = Set(parts.last!.components(separatedBy: " ").compactMap { Int($0) })
    }
    
    var numberOfWins: Int {
        return self.myNumbers.intersection(self.winnningNumbers).count
    }
    
    var points: Int {
        return Int(pow(2, Double(self.numberOfWins - 1)))
    }
}

struct Day04_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    
    private var cards: [Card_2024] {
        return self.data.components(separatedBy: "\n")
            .filter { !$0.isEmpty}
            .map { Card_2024(from: $0) }
    }
    
    
    func part1() -> Any {
        return self.cards.map { $0.points }.reduce(0, +)
    }
    
    func part2() -> Any {
        var copies = [Int](repeating: 1, count: self.cards.count + 1)
        copies[0] = 0

        for card in self.cards where card.numberOfWins > 0 {
            for i in card.id + 1 ... card.id + card.numberOfWins {
                copies[i] += copies[card.id]
            }
        }
        return copies.reduce(0, +)
    }
}
