import Algorithms

struct Day01_2025: AdventChallenge {
    static var year: Int { 2025 }
    
    var distances: [Int] = []
    var data: String
    
    init(data: String) {
        self.data = data
        self.distances = self.data
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .compactMap { str -> Int? in
                guard let op = str.first?.lowercased(),
                      let position = Int(str.dropFirst()) else {
                    return nil
                }
                
                switch op {
                case "l":  return -position
                case "r": return position
                default: return nil
                }
            }
    }
    
    func part1() async throws -> Any {
        var position = 50
        var zeroCount = 0
        
        for distance in self.distances {
            let steps = distance % 100
            position += steps
            
            if position < 0 {
                position += 100
            } else if position >= 100 {
                position -= 100
            }
            
            if position == 0 {
                zeroCount += 1
            }
        }
        
        return zeroCount
    }
    
    func part2() async throws -> Any {
        var position = 50
        var zeroCount = 0
        
        for distance in self.distances {
            if distance > 0 {
                zeroCount += (position + distance) / 100
            } else if distance < 0 {
                let d = -distance
                if position == 0 {
                    zeroCount += d / 100
                } else if d >= position {
                    zeroCount += (d - position) / 100 + 1
                }
            }
            
            position = ((position + distance) % 100 + 100) % 100
        }
        
        return zeroCount
    }
}
