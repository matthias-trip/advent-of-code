import Foundation

struct Grid<Value> {
    let rows: Int
    let cols: Int
    
    private var storage: [[Value]]
    
    init(_ storage: [[Value]]) {
        self.rows = storage.count
        self.cols = storage.first?.count ?? 0
        self.storage = storage
    }
    
    func isValid(_ position: Position) -> Bool {
        position.row >= 0 && position.row < self.rows && position.col >= 0 && position.col < self.cols
    }
    
    func value(at position: Position) -> Value? {
        guard self.isValid(position) else {
            return nil
        }
        return self.storage[position.row][position.col]
    }
    
    mutating func setValue(_ value: Value, at position: Position) {
        guard self.isValid(position) else {
            return
        }
        self.storage[position.row][position.col] = value
    }
    
    func allPositions() -> [Position] {
        return (0..<rows).flatMap { row in
            (0..<cols).map { col in
                Position(row: row, col: col)
            }
        }
    }
    
    func adjacentPositions(of position: Position) -> [Position] {
        let offsets = [
            (-1, -1), (-1, 0), (-1, 1),
            ( 0, -1),          ( 0, 1),
            ( 1, -1), ( 1, 0), ( 1, 1)
        ]
        
        return offsets
            .map { Position(row: position.row + $0.0, col: position.col + $0.1) }
            .filter { self.isValid($0) }
    }
    
    func adjacentValues(of position: Position) -> [Value] {
        self.adjacentPositions(of: position)
            .compactMap { self.value(at: $0) }
    }
}
