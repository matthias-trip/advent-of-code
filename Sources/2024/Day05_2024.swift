import Algorithms
import Foundation

struct Almanac {
    
    struct Map {
        let identifier: String
        let ranges: [Range]
        
        init(from lines: [String]) {
            self.identifier = lines.first!
            self.ranges = lines.dropFirst().map { Range(from: $0) }.sorted { $0.from < $1.from }
        }
    }
    
    struct Range {
        
        let from: Int
        let to: Int
        let adjustment: Int
        
        init(from: Int, to: Int, adjustment: Int = 0) {
            self.from = from
            self.to = to
            self.adjustment = adjustment
        }
        
        
        init(from line: String) {
            let components = line.components(separatedBy: " ")
            
            self.from = Int(components[1])!
            self.to = Int(components[1])! + Int(components[2])! - 1
            self.adjustment = Int(components[0])! - Int(components[1])!
        }
        
        func contains(_ x: Int) -> Bool {
            return x >= from && x <= to
        }
        
        var isValid: Bool { from <= to }
    }
    
    let seeds: [Int]
    let maps: [Map]
    
    init(from lines: [String]) {
        self.seeds = lines.first!.components(separatedBy: " ").compactMap { Int($0) }
        self.maps = Array(lines.dropFirst(2)).group { $0.isEmpty }.map { Map(from: $0) }
    }
    
    func location(for seed: Int) -> Int {
        var seed = seed
        for map in maps {
            if let range = map.ranges.first(where: { $0.contains(seed) }) {
                seed += range.adjustment
            }
        }
        return seed
    }
}

struct Day05_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    
    func part1() -> Any {
        let almanac = Almanac(from: self.data.components(separatedBy: "\n"))
        var minLocation = Int.max
        for seed in almanac.seeds {
            let location = almanac.location(for: seed)
            minLocation = min(minLocation, location)
        }
        return minLocation
    }
    
    func part2() -> Any {
        let almanac = Almanac(from: self.data.components(separatedBy: "\n"))
        
        var ranges = almanac.seeds
            .chunked(2)
            .compactMap { Almanac.Range(from: $0[0], to: $0[0] + $0[1] - 1) }
        
        for map in almanac.maps {
            var newRanges = [Almanac.Range]()
            for r in ranges {
                var range = r
                for mapping in map.ranges {
                    if range.from < mapping.from {
                        newRanges.append(Almanac.Range(from: range.from,
                                                       to: min(range.to, mapping.from - 1)))
                        range = Almanac.Range(from: mapping.from, to: range.to)
                        if !range.isValid {
                            break
                        }
                    }
                    if range.from <= mapping.to {
                        newRanges.append(Almanac.Range(from: range.from + mapping.adjustment,
                                                       to: min(range.to, mapping.to) + mapping.adjustment))
                        range = Almanac.Range(from: mapping.to + 1, to: range.to)
                        if !range.isValid {
                            break
                        }
                    }
                }
                if range.isValid {
                    newRanges.append(range)
                }
            }
            ranges = newRanges
        }
        
        return ranges.min(of: \.from)!
    }
    
}
