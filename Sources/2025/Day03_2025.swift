import Algorithms

struct Day03_2025: AdventChallenge {
    static var year: Int { 2025 }
    
    var data: String
    var batteries = [[Int]]()

    init(data: String) {
        self.data = data
        self.batteries = self.data
            .components(separatedBy: .newlines)
            .map { $0.compactMap(\.wholeNumberValue) }
            .filter { !$0.isEmpty }
    }
    
    func largestJoltage(from batteries: [Int], digits: Int) -> Int {
        (0..<digits)
            .reversed()
            .reduce((currentIndex: 0, value: 0)) { state, left in
                let (currentIndex, value) = state
                let (ix, v) = batteries.enumerated()
                    .dropFirst(currentIndex)
                    .dropLast(left)
                    .max(by: { $0.element < $1.element })!
                
                return (ix + 1, value * 10 + v)
            }
            .value
    }
    
    func part1() async throws -> Any {
        self.batteries
            .map { self.largestJoltage(from: $0, digits: 2) }
            .reduce(0, +)
    }
    
    func part2() async throws -> Any {
        self.batteries
            .map { self.largestJoltage(from: $0, digits: 12) }
            .reduce(0, +)
    }
}
