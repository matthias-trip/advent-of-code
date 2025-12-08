import Algorithms

struct Day04_2025: AdventChallenge {
    static var year: Int { 2025 }
    private static let paperRoll: Character = "@"
    
    var data: String
    let grid: Grid<Character>
    
    init(data: String) {
        self.data = data
        let gridData = data
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Array($0) }
        
        self.grid = Grid(gridData)
    }
    
    func part1() async throws -> Any {
        let paperPositions = self.grid.allPositionsWithValue(Self.paperRoll)
        return paperPositions
            .filter { self.hasPaperRoll(at: $0, on: self.grid) && self.hasReachablePaperRoll(at: $0, on: self.grid) }
            .count
    }
    
    func part2() async throws -> Any {
        var totalRemoved = 0
        var removedInCurrentIteration = 0
        
        var grid = self.grid
        
        while(true) {
            removedInCurrentIteration = 0
            let paperPositions = grid.allPositionsWithValue(Self.paperRoll)
            
            for position in paperPositions {
                if self.hasReachablePaperRoll(at: position, on: grid) {
                    removedInCurrentIteration += 1
                    totalRemoved += 1
                    
                    grid.setValue("x", at: position)
                }
            }
            
            if removedInCurrentIteration == 0 {
                break
            }
        }
        
        
        return totalRemoved
    }
    
    private func hasPaperRoll(at position: Position, on grid: Grid<Character>) -> Bool {
        return grid.value(at: position) == Self.paperRoll
    }
    
    private func hasReachablePaperRoll(at position: Position, on grid: Grid<Character>) -> Bool {
        return grid.adjacentValues(of: position).count(where: { $0 == Self.paperRoll }) < 4
    }
}

extension Grid where Value == Character {
    func allPositionsWithValue(_ value: Character) -> [Position] {
        return self.allPositions().filter{ self.value(at: $0) == value }
    }
}
