import Algorithms

struct Day02_2025: AdventChallenge {
    static var year: Int { 2025 }
    
    var data: String
    let ranges: [Int]

    init(data: String) {
        self.data = data
        self.ranges = self.data
            .split(separator: ",")
            .compactMap { range in
                let ranges = range
                    .split(separator: "-")
                    .compactMap {
                        let str = String($0).replacingOccurrences(of: "\n", with: "")
                        return Int(str)
                    }
                
                return Array(ranges[0]...ranges[1])
            }
            .reduce(into: Array<Int>()) { $0.append(contentsOf: $1) }
    }
    
    func part1() async throws -> Any {
        return self.ranges.filter {
            let chunks = String($0).evenlyChunked(in: 2)
            guard let first = chunks.first, let last = chunks.last else {
                return false
            }
            
            return first.elementsEqual(last)
        }
        .reduce(0, +)
    }

    func part2() async throws -> Any {
        return self.ranges.filter {
            let str = String($0)
            let range = 1..<str.count
            
            return range.contains {
                let chunks = str.chunks(ofCount: $0)
                return Set(chunks).count == 1
            }
        }
        .reduce(0, +)
    }
}
