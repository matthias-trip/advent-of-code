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
        let paperPositions = self.grid.allPositions()
            .filter { self.grid.value(at: $0) == Self.paperRoll }
        
        return paperPositions
            .filter {
                return self.grid.value(at: $0) == Self.paperRoll
            }
            .filter {
                return self.grid.adjacentValues(of: $0).count(where: { $0 == Self.paperRoll }) < 4
            }
            .count
    }
}
