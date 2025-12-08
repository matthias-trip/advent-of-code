import Algorithms

struct Day05_2025: AdventChallenge {
    static var year: Int { 2025 }
   
    var data: String
    
    let freshIngredients: RangeSet<Int>
    let ingredients: [Int]
    
    init(data: String) {
        self.data = data
        
        let lines = self.data.components(separatedBy: .newlines)
        let ranges = lines
            .filter { $0.contains("-") }
            .map {
                $0.components(separatedBy: "-")
                    .compactMap(Int.init)
            }
            .map { Range($0[0]...$0[1]) }

        self.ingredients = lines
            .filter { !$0.contains("-") }
            .compactMap(Int.init)
        
        self.freshIngredients = RangeSet(ranges)
    }
    
    func part1() async throws -> Any {
        return self.ingredients.count {
            return self.freshIngredients.contains($0)
        }
    }
}
