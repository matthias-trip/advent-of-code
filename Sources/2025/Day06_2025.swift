import Algorithms


struct Day06_2025: AdventChallenge {
    
    struct Puzzle {
        enum Operation: String {
            case addition = "+"
            case multiplication = "*"
        }
        
        let numbers: [Int]
        let operation: Operation
        
        func solve() -> Int {
            switch self.operation {
            case .addition:
                return self.numbers.reduce(0, +)
            case .multiplication:
                return self.numbers.reduce(1, *)
            }
        }
    }
    
    static var year: Int { 2025 }
    
    var data: String
    let puzzles: [Puzzle]

    init(data: String) {
        self.data = data
        
        let lines = self.data
            .components(separatedBy: .newlines)
            .dropLast()
        
        let rows = lines
            .dropLast()
            .map { $0
                .components(separatedBy: .whitespaces)
                .compactMap { Int($0) }
            }
        
        let operators = lines
            .last!
            .split(separator: " ")
            .map {
                Puzzle.Operation(rawValue: String($0))!
            }
        
        var puzzles: [Puzzle] = []
        for (col, op) in operators.enumerated() {
            let numbers = rows.map { $0[col] }
            puzzles.append(Puzzle(numbers: numbers, operation: op))
        }
        
        self.puzzles = puzzles
    }
    
    func part1() async throws -> Any {
        return self.puzzles
            .reduce(0) { $0 + $1.solve() }
    }
}
