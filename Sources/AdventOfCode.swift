import ArgumentParser

// Add each new year's challenges to this dictionary:
let challengesByYear: [Int: [any AdventChallenge.Type]] = [
  2024: [
    Day01_2024.self,
    Day02_2024.self,
    Day03_2024.self,
    Day04_2024.self,
    Day05_2024.self,
    Day06_2024.self,
    Day07_2024.self,
    Day08_2024.self,
    Day09_2024.self,
    Day10_2024.self
  ],
  2025: [
    Day01_2025.self,
    Day02_2025.self,
    Day03_2025.self,
    Day04_2025.self
  ]
]

// Default year for convenience
let defaultYear = 2025

@main
struct AdventOfCode: AsyncParsableCommand {
  @Option(name: .shortAndLong, help: "The year of the challenge (e.g., 2024, 2025).")
  var year: Int?

  @Argument(help: "The day of the challenge. For December 1st, use '1'.")
  var day: Int?

  @Flag(help: "Benchmark the time taken by the solution")
  var benchmark: Bool = false

  /// The selected year, or the default year if no selection is provided.
  var selectedYear: Int {
    year ?? defaultYear
  }

  /// The challenge types for the selected year.
  var yearChallengeTypes: [any AdventChallenge.Type] {
    get throws {
      guard let challenges = challengesByYear[selectedYear] else {
        throw ValidationError("No challenges found for year \(selectedYear)")
      }
      return challenges
    }
  }

  /// The selected day, or the latest day if no selection is provided.
  /// Only initializes the challenge that's actually needed.
  var selectedChallenge: any AdventChallenge {
    get throws {
      let challengeTypes = try yearChallengeTypes
      if let day {
        if let challengeType = challengeTypes.first(where: { $0.day == day }) {
          return challengeType.init()
        } else {
          throw ValidationError("No solution found for day \(day) in year \(selectedYear)")
        }
      } else {
        return try latestChallenge
      }
    }
  }

  /// The latest challenge in the selected year.
  var latestChallenge: any AdventChallenge {
    get throws {
      let challengeTypes = try yearChallengeTypes
      let latestType = challengeTypes.max(by: { $0.day < $1.day })!
      return latestType.init()
    }
  }

  func run(part: () async throws -> Any, named: String) async -> Duration {
    var result: Result<Any, Error> = .success("<unsolved>")
    let timing = await ContinuousClock().measure {
      do {
        result = .success(try await part())
      } catch {
        result = .failure(error)
      }
    }
    switch result {
    case .success(let success):
      print("\(named): \(success)")
    case .failure(let failure):
      print("\(named): Failed with error: \(failure)")
    }
    return timing
  }

  func run() async throws {
    let challenge = try selectedChallenge
    print("Executing Advent of Code \(challenge.year) - Day \(challenge.day)...")

    let timing1 = await run(part: challenge.part1, named: "Part 1")
    let timing2 = await run(part: challenge.part2, named: "Part 2")

    if benchmark {
      print("Part 1 took \(timing1), part 2 took \(timing2).")
      #if DEBUG
        print("Looks like you're benchmarking debug code. Try swift run -c release")
      #endif
    }
  }
}
