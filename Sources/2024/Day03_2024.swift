import Algorithms
import Foundation

struct Day03_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    
    private var symbols: Set<Point> = []
    private var gears: Set<Point> = []
    private var numbers: Set<Number> = []
    
    public struct Point: Hashable {
        public let x, y: Int
        
        public init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
    }
    
    private struct Number: Hashable {
        let value: Int
        let start: Point
        let length: Int
        let neighbors: Set<Point>
        
        init(value: Int, start: Point, length: Int) {
            self.value = value
            self.start = start
            self.length = length
            neighbors = Set(
                (start.y - 1 ... start.y + 1).flatMap { y in
                    (start.x - 1 ... start.x + length).map { x in
                        Point(x, y)
                    }
                }
            )
        }
    }
    
    init(data: String) {
        self.data = data
        
        var symbols = Set<Point>()
        var gears = Set<Point>()
        var numbers = Set<Number>()
        
        let lines = self.data.components(separatedBy: "\n").filter { !$0.isEmpty }.enumerated()
        for (y, line) in lines {
            for (x, ch) in line.enumerated() {
                if !(ch.isNumber || ch == ".") {
                    symbols.insert(Point(x, y))
                    if ch == "*" {
                        gears.insert(Point(x, y))
                    }
                }
            }
            
            let digits = line.enumerated().filter { $1.isNumber }
            if digits.isEmpty { continue }
            
            var value = digits[0].element.wholeNumberValue!
            var start = digits[0].offset
            var prevOffset = start
            var length = 1
            for d in digits.dropFirst() {
                if d.offset == prevOffset + 1 {
                    value = value * 10 + d.element.wholeNumberValue!
                    length += 1
                    prevOffset = d.offset
                } else {
                    numbers.insert(Number(value: value, start: Point(start, y), length: length))
                    value = d.element.wholeNumberValue!
                    length = 1
                    start = d.offset
                    prevOffset = start
                }
            }
            numbers.insert(Number(value: value, start: Point(start, y), length: length))
        }
        
        self.symbols = symbols
        self.gears = gears
        self.numbers = numbers
    }
    
    
    func part1() -> Any {
        return numbers.filter { !symbols.intersection($0.neighbors).isEmpty }
            .map { $0.value }
            .reduce(0, +)
    }
    
    func part2() -> Any {
        let gearsFound = gears.map { gear in
            numbers.filter { $0.neighbors.contains(gear) }
        }
        return gearsFound.filter { $0.count == 2 }
            .map { number in
                number.map { $0.value }.reduce(1, *)
            }
            .reduce(0, +)
    }
    
}
