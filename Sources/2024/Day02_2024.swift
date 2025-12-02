import Algorithms
import Foundation

struct Day02_2024: AdventChallenge {
    static var year: Int { 2024 }

    private struct Game {
        let id: Int
        let sets: [Set]
        
        var power: Int {
            let maxRed = sets.max { $0.red < $1.red }!.red
            let maxGreen = sets.max { $0.green < $1.green }!.green
            let maxBlue = sets.max { $0.blue < $1.blue }!.blue
            
            return maxRed * maxGreen * maxBlue
        }
        
        var isPossible: Bool {
            return self.sets.allSatisfy { $0.isPossible }
        }
        
        struct Set {
            var red = 0
            var blue = 0
            var green = 0
            
            init(red: Int, blue: Int, green: Int) {
                self.red = red
                self.blue = blue
                self.green = green
            }
            
            init(from string: String) {
                let colors = string.components(separatedBy: ", ").map {
                    $0.components(separatedBy: " ")
                }
                
                for color in colors {
                    switch color.last {
                    case "red":
                        self.red = Int(color.first!)!
                    case "blue":
                        self.blue = Int(color.first!)!
                    case "green":
                        self.green = Int(color.first!)!
                    default:
                        fatalError("Unknown color")
                    }
                }
            }
            
            var isPossible: Bool {
                self.red <= 12 && self.green <= 13 && self.blue <= 14
            }
        }
        
        init(from line: String) {
            let components = line.components(separatedBy: ": ")
            
            self.id = Int(components.first!.components(separatedBy: " ").last!)!
            self.sets = components.last!.components(separatedBy: "; ").map { Set(from: $0) }
        }
    }
    
    var data: String
    
    private var games: [Game] {
        return self.data.components(separatedBy: "\n").filter{ !$0.isEmpty }.map{ Game(from: $0) }
    }
    
    func part1() async throws -> Any {
        return self.games.filter { $0.isPossible }.reduce(0) { $0 + $1.id }
    }
    
    func part2() async throws -> Any {
        return self.games.reduce(into: 0, { $0 += $1.power })
    }
}
