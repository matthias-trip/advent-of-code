import Algorithms


struct Day07_2025: AdventChallenge {
   
    static var year: Int { 2025 }
    
    var data: String

    init(data: String) {
        self.data = data
    }
    
    func part1() async throws -> Any {
        self.data.replacingOccurrences(of: "S", with: "|")
            .components(separatedBy: .newlines)
            .map(Array.init)
            .reductions {
                zip(".\(String($0)).", ".\(String($1)).")
                    .map { "\($0.0)\($0.1)" }
                    .windows(ofCount: 3)
                    .map(Array.init)
                    .map {
                        if $0[1] == "|^" {
                            "#"
                        } else if $0[1].first == "|" || [$0[0], $0[2]].contains("|^") {
                            "|"
                        } else {
                            $0[1].last ?? "."
                        }
                    }
            }
            .joined()
            .count { $0 == "#" }
    }
}
