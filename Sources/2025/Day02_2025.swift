import Algorithms

struct Day02_2025: AdventChallenge {
    static var year: Int { 2025 }
    
    var data: String

    init(data: String) {
        self.data = data
    }
    
    func part1() async throws -> Any {
        let result = self.data
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
            .filter {
                let str = String($0).evenlyChunked(in: 2)
                guard let first = str.first, let last = str.last else {
                    return false
                }
                
                return first.elementsEqual(last)
            }
            .reduce(0, +)
        
        return result
    }

}
