import Foundation

struct Position {
    let row: Int
    let col: Int
    
    static func + (lhs: Position, rhs: Position) -> Position {
        Position(row: lhs.row + rhs.row, col: lhs.col + rhs.col)
    }
    
    static func + (lhs: Position, rhs: Direction) -> Position {
        switch rhs {
        case .up:
            return Position(row: lhs.row - 1, col: lhs.col)
        case .down:
            return Position(row: lhs.row + 1, col: lhs.col)
        case .left:
            return Position(row: lhs.row, col: lhs.col - 1)
        case .right:
            return Position(row: lhs.row, col: lhs.col + 1)
        }
    }
}
