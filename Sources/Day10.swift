import Foundation

import Algorithms

struct Day10: AdventDay {
    enum Tile: Character {
        case ns = "|"
        case ew = "-"
        case ne = "L"
        case nw = "J"
        case sw = "7"
        case se = "F"
        case ground = "."
        case start = "S"
    }
    
    public enum Direction: String, CaseIterable {
        case n, w, s, e
        case nw, ne, sw, se
        
        public var offset: Point {
            switch self {
            case .n: Point(0, -1)
            case .w: Point(-1, 0)
            case .s: Point(0, 1)
            case .e: Point(1, 0)
            case .nw: Point(-1, -1)
            case .ne: Point(1, -1)
            case .sw: Point(-1, 1)
            case .se: Point(1, 1)
            }
        }
    }
    
    struct Point: Hashable {
        public let x, y: Int
        
        public static let zero = Point(0, 0)
        
        @inlinable
        public init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
        
        @inlinable
        public func moved(to direction: Direction) -> Point {
            self + direction.offset
        }
        
        @inlinable
        public static func + (_ lhs: Point, _ rhs: Point) -> Point {
            Point(lhs.x + rhs.x, lhs.y + rhs.y)
        }
    }
    
    let data: String
    let field: [[Tile]]
    
    init(data: String) {
        self.data = data
        self.field = self.data.components(separatedBy: "\n")
            .filter { !$0.isEmpty}
            .map {
                $0.map { Tile(rawValue: $0)! }
            }
    }
    
    func part1() -> Any {
        let (field, start) = findStart(in: field)
        let path = findPath(in: field, from: start)
        return path.count / 2
        
    }
    
    func part2() -> Any {
        let (field, start) = findStart(in: field)
        let path = findPath(in: field, from: start)
        
        var crossing = 0
        var inside = 0
        
        // apply non-zero winding rule
        for y in 0 ..< field.count - 1 {
            for x in 0 ..< field[y].count {
                let point = Point(x, y)
                if let steps = path[point] {
                    if let stepsBelow = path[point.moved(to: .s)] {
                        // point below is also on path, check for crossing
                        if stepsBelow == (steps + 1) % path.count {
                            crossing += 1
                        }
                        if steps == (stepsBelow + 1) % path.count {
                            crossing -= 1
                        }
                    }
                } else {
                    // point is not on path, it's inside for non-zero crossings
                    if crossing != 0 {
                        inside += 1
                    }
                }
            }
        }
        
        return inside
    }
    
    private func findPath(in field: [[Tile]], from start: Point) -> [Point: Int] {
        var current = start
        var steps = 0
        var path = [current: steps]
        var lastDirection: Direction?
        repeat {
            let direction = chooseDirection(field[current], lastDirection)
            current = current.moved(to: direction)
            lastDirection = direction
            steps += 1
            path[current] = steps
        } while current != start
        
        return path
    }
    
    
    private func chooseDirection(_ current: Tile, _ lastDirection: Direction?) -> Direction {
        switch current {
        case .ns: lastDirection == .n ? .n : .s
        case .ew: lastDirection == .e ? .e : .w
        case .ne: lastDirection == .s ? .e : .n
        case .nw: lastDirection == .s ? .w : .n
        case .sw: lastDirection == .n ? .w : .s
        case .se: lastDirection == .n ? .e : .s
        case .ground, .start:
            fatalError()
        }
    }
    
    private func findStart(in field: [[Tile]]) -> ([[Tile]], Point) {
        var field = field
        var start = Point.zero
    findStart:
        for y in 0 ..< field.count {
            for x in 0 ..< field[y].count {
                if field[y][x] == .start {
                    start = Point(x, y)
                    break findStart
                }
            }
        }
        assert(start != .zero)
        
        let sNorth = [Tile.ns, Tile.sw, Tile.se].contains(field[start.moved(to: .n)])
        let sWest = [Tile.se, Tile.ne, Tile.ew].contains(field[start.moved(to: .w)])
        let sSouth = [Tile.ns, Tile.nw, Tile.ne].contains(field[start.moved(to: .s)])
        let sEast = [Tile.nw, Tile.sw, Tile.ew].contains(field[start.moved(to: .e)])
        
        let startPipe: Tile
        switch (sNorth, sWest, sSouth, sEast) {
        case (true, true, false, false): startPipe = .nw
        case (true, false, true, false): startPipe = .ns
        case (true, false, false, true): startPipe = .ne
        case (false, true, true, false): startPipe = .sw
        case (false, true, false, true): startPipe = .ew
        case (false, false, true, true): startPipe = .se
        default: fatalError()
        }
        
        field[start] = startPipe
        return (field, start)
    }
    
}

private extension Array where Element == [Day10.Tile] {
    subscript(index: Day10.Point) -> Day10.Tile {
        get {
            guard 0..<count ~= index.y, 0..<self[index.y].count ~= index.x else { return .ground }
            return self[index.y][index.x]
        }
        set { self[index.y][index.x] = newValue }
    }
}
