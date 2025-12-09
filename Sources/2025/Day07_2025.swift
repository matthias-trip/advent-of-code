import Algorithms


struct Day07_2025: AdventChallenge {
    
    enum Symbols: String {
        case start = "S"
        case empty = "."
        case splitter = "^"
        case beam = "|"
    }
   
    static var year: Int { 2025 }
    
    var data: String
    var grid: Grid<Symbols>

    init(data: String) {
        self.data = data

        self.grid = Grid(
            self.data
                .components(separatedBy: .newlines)
                .filter { !$0.isEmpty }
                .compactMap {
                    Array($0)
                        .compactMap { return Symbols(rawValue: String($0)) }
                }
        )
    }
    
    func part1() async throws -> Any {
        guard let startPosition = self.grid.position(for: .start).first else {
            fatalError("Start position not found")
        }
        
        var grid = self.grid
        return self.splitCount(on: &grid, at: startPosition)
    }
    
    private func splitCount(on grid: inout Grid<Symbols>, at position: Position) -> Int {
        guard let symbol = grid.value(at: position) else {
            return 0
        }
        
        switch symbol {
        case .start, .empty:
            return self.splitCount(on: &grid, at: (position + .down))
        case .splitter:
            let leftPosition = (position + .left)
            let rightPosition = (position + .right)
            
            let splitCount = self.splitCount(on: &grid, at: (position + .left)) +
                             self.splitCount(on: &grid, at: (position + .right))
                             + 1
            
            grid.setValue(.beam, at: leftPosition)
            grid.setValue(.beam, at: rightPosition)
            
            return splitCount
        case .beam:
            return 0
        }
    }
}
