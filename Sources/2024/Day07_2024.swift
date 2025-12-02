import Algorithms

struct Day07_2024: AdventChallenge {
    static var year: Int { 2024 }

    static var cardRank: Dictionary<String, Int> = ["A": 14,
                                                    "K": 13,
                                                    "Q": 12,
                                                    "J": 11,
                                                    "T": 10,
                                                    "9": 9,
                                                    "8": 8,
                                                    "7": 7,
                                                    "6": 6,
                                                    "5": 5,
                                                    "4": 4,
                                                    "3": 3,
                                                    "2": 2]
    
    // In part 2, card "J" is now just weighted as 1
    static var jokerCardRank = Day07_2024.cardRank.merging(["J": 1]) { $1 }
    
    enum Rank: Int, Comparable {
        case highCard
        case onePair
        case twoPair
        case threeOfAKind
        case fullHouse
        case fourOfaKind
        case fiveOfaKind
        
        static func < (lhs: Day07_2024.Rank, rhs: Day07_2024.Rank) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        func jokerRank(for numberOfJokers: Int) -> Rank {
            switch self {
            case .highCard: return .onePair
            case .onePair: return .threeOfAKind
            case .twoPair: return (numberOfJokers == 2 ? .fourOfaKind : .fullHouse)
            case .threeOfAKind: return .fourOfaKind
            case .fullHouse: return .fiveOfaKind
            case .fourOfaKind: return .fiveOfaKind
            case .fiveOfaKind: return .fiveOfaKind
            }
        }
    }
    
    struct Hand {
        
        var cards: [String]
        var bid: Int
        
        var rank: Rank {
            
            let countPerCard = self.cards.reduce(into: [:]) { counts, card in
                counts[card, default: 0] += 1
            }
            
            switch countPerCard.count {
            case 1: return .fiveOfaKind
            case 2: return countPerCard.values.contains(4) ?
                    .fourOfaKind :
                    .fullHouse
            case 3: return countPerCard.values.contains(3) ?
                    .threeOfAKind :
                    .twoPair
            case 4: return .onePair
            case 5: return .highCard
            default: assertionFailure("Should not happen! Always max. 5 cards")
            }
            
            return .fiveOfaKind
        }
        
        var numberOfJokers: Int {
            return self.cards.filter{ $0 == "J" }.count
        }
        
        init(from line: String) {
            let parts = line.components(separatedBy: " ")
            
            self.cards = parts.first!.map { String($0) }
            self.bid = Int(parts.last!)!
        }
    }
    
    var data: String
    
    func part1() -> Any {
        return self.data.components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { Hand(from: $0) }
            .sorted { lhs, rhs in
                // Try to compare the ranks if they are different from eachother
                if lhs.rank != rhs.rank {
                    return lhs.rank < rhs.rank
                }
                
                // If the ranks are equal find the card with the highest individual ranking
                for (c1, c2) in zip(lhs.cards, rhs.cards) {
                    if c1 != c2 {
                        return Day07_2024.cardRank[c1]! < Day07_2024.cardRank[c2]!
                    }
                }
                
                return false
            }
            .enumerated()
            .reduce(0) {
                $0 + ($1.offset + 1) * $1.element.bid
            }
        
    }
    
    func part2() -> Any {
        return self.data.components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { Hand(from: $0) }
            .sorted { lhs, rhs in
                let lhsJokerRank = lhs.rank.jokerRank(for: lhs.numberOfJokers)
                let rhsJokerRank = rhs.rank.jokerRank(for: rhs.numberOfJokers)
                
                // Try to compare the ranks if they are different from eachother
                if lhsJokerRank != rhsJokerRank {
                    return lhsJokerRank < rhsJokerRank
                }
                
                // If the ranks are equal find the card with the highest individual ranking
                for (c1, c2) in zip(lhs.cards, rhs.cards) {
                    if c1 != c2 {
                        return Day07_2024.jokerCardRank[c1]! < Day07_2024.jokerCardRank[c2]!
                    }
                }
                
                return false
            }
            .enumerated()
            .reduce(0) {
                $0 + ($1.offset + 1) * $1.element.bid
            }
        
    }
}
