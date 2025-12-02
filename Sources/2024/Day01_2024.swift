import Algorithms

struct Day01_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    var lines: [String] {
        return self.data.components(separatedBy: "\n").filter { $0.isEmpty == false }
    }
    
    let replaceWordWithNumber = ["one": "o1e",
                                 "two": "t2o",
                                 "three": "t3e",
                                 "four": "f4r",
                                 "five": "f5e",
                                 "six": "s6x",
                                 "seven": "s7n",
                                 "eight": "e8t",
                                 "nine": "n9e"]

    func part1() -> Any {
        return self.sumOfCallibrationValues(self.lines)
    }
    
    func part2() -> Any {
        let linesWithNumbersReplaced = self.lines.map {
            var line = $0
            for(word, replacement) in self.replaceWordWithNumber {
                line = line.replacingOccurrences(of: word, with: replacement)
            }
            
            return line
        }
        
        return self.sumOfCallibrationValues(linesWithNumbersReplaced)
    }
    
    private func sumOfCallibrationValues(_ values: [String]) -> Int {
        return values.reduce(0) { partialResult, line in
            let digits = line.compactMap{ $0.wholeNumberValue }
            return partialResult + digits.first! * 10 + digits.last!
        }
    }
}
