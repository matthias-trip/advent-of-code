import Algorithms

struct Day02_2025: AdventChallenge {
    static var year: Int { 2025 }
    
    var data: String
    var ranges:  [ClosedRange<Int>]
    
    init(data: String) {
        self.data = data
        self.ranges = self.data
            .components(separatedBy: ",")
            .compactMap {
                let range = $0.components(separatedBy: "-")
                guard let start = Int(range[0]),
                      let end = Int(range[1]) else {
                    return nil
                }
                
                return start...end
        }
    }
    
    func part1() async throws -> Any {
        let uniqueIDs = Set(self.ranges.flatMap { $0 })
        
        return uniqueIDs
            .compactMap { $0 }
            .filter(isInvalid)
            .reduce(0, +)
    }
    
    func isInvalid(_ n: Int) -> Bool {
        let s = String(n)
        let len = s.count
        
        guard len >= 2 && len % 2 == 0 else { return false }
        
        let halfLen = len / 2
        let firstHalf = s.prefix(halfLen)
        let secondHalf = s.suffix(halfLen)
        
        return firstHalf == secondHalf
    }
 
}
