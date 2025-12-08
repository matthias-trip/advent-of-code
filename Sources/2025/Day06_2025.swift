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
    
    func part2() async throws -> Any {
        let numbers = self.data
            .components(separatedBy: .newlines)
            .dropLast()
            .map {
                Array($0)
                    .map(\.wholeNumberValue)
            }
            .reductions {
                zip($0, $1)
                    .map {
                        $1 != nil ? ($0 ?? 0) * 10 + ($1 ?? 0) : $0
                    }
            }
            .last
            
    
           return numbers.map { (nums: [Int?]) -> Int in
                zip(
                    nums.split(separator: nil),
                    self.data.filter { "+*".contains($0) },
                )
                .compactMap {
                    $0
                        .compacted()
                        .reductions($1 == "+" ? (+) : (*))
                        .last
                }
                .reduce(0, +)
            } ?? 0
    }
}
