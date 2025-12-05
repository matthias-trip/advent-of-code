import Algorithms

struct Day03_2025: AdventChallenge {
    static var year: Int { 2025 }
    
    var data: String
    var batteries = [[Int]]()

    init(data: String) {
        self.data = data
        self.batteries = self.data
            .components(separatedBy: .newlines)
            .map {$0.compactMap(\.wholeNumberValue) }
    }
    
    func part1() async throws -> Any {
        return self.batteries
            .compactMap {
                $0.combinations (ofCount: 2)
                    .map {$0[0] * 10 + $0[1] }
                    .max ()
        }.reduce(0, +)
    }
}
