import Algorithms

private struct Race {
    let time: Int
    let distance: Int

    func waysToWin() -> Int {
        var startWinning = 0
        var endWinning = 0

        for press in 1 ..< time {
            let distance = press * (time - press)
            if distance > self.distance {
                startWinning = press
                break
            }
        }

        for press in (1 ..< time).reversed() {
            let distance = press * (time - press)
            if distance > self.distance {
                endWinning = press
                break
            }
        }

        return endWinning - startWinning + 1
    }
}

struct Day06_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    
    fileprivate var lines: [String] {
        return self.data.components(separatedBy: "\n")
    }
    
    func part1() -> Any {
        let times = self.lines[0].components(separatedBy: " ").compactMap { Int($0) }
        let distances = self.lines[1].components(separatedBy: " ").compactMap { Int($0) }
        
        let races = zip(times, distances).map { Race(time: $0, distance: $1) }
        
        return races.map { $0.waysToWin() }.reduce(1, *)
    }

    func part2() async throws -> Any {
        let totalTime = Int(self.lines[0].dropFirst(10).replacingOccurrences(of: " ", with: ""))!
        let totalDistance = Int(self.lines[1].dropFirst(10).replacingOccurrences(of: " ", with: ""))!
        
        let race = Race(time: totalTime, distance: totalDistance)
        
        return race.waysToWin()
    }
}
