@_exported import Algorithms
@_exported import Collections
import Foundation

protocol AdventChallenge {
  /// The year of the Advent of Code challenge.
  ///
  /// You can implement this property, or, if your type is in a folder named
  /// with the year (like `2024/Day01`), it is derived automatically.
  static var year: Int { get }

  /// The day of the Advent of Code challenge.
  ///
  /// You can implement this property, or, if your type is named with the
  /// day number as its suffix (like `Day01`), it is derived automatically.
  static var day: Int { get }

  /// An initializer that uses the provided test data.
  init(data: String)

  /// Computes and returns the answer for part one.
  func part1() async throws -> Any

  /// Computes and returns the answer for part two.
  func part2() async throws -> Any
}

extension AdventChallenge {
  // Default year - should be overridden by each year's challenges
  static var year: Int {
    fatalError(
      """
      Year not found: implement the static `year` property \
      in your AdventChallenge implementation.
      """)
  }

  var year: Int {
    Self.year
  }

  // Find the challenge day from the type name (e.g., Day01_2024 -> 1, Day01 -> 1).
  static var day: Int {
    let typeName = String(reflecting: Self.self)
    // Find "Day" and extract the number immediately following it
    guard let dayRange = typeName.range(of: "Day") else {
      fatalError(
        """
        Day number not found in type name: \
        implement the static `day` property \
        or use the day number as your type's suffix (like `Day01_2024`).
        """)
    }
    let afterDay = typeName[dayRange.upperBound...]
    let endIndex = afterDay.firstIndex(where: { !$0.isNumber }) ?? afterDay.endIndex
    guard let day = Int(typeName[dayRange.upperBound..<endIndex]) else {
      fatalError(
        """
        Day number not found in type name: \
        implement the static `day` property \
        or use the day number as your type's suffix (like `Day01_2024`).
        """)
    }
    return day
  }

  var day: Int {
    Self.day
  }

  // Default implementation of `part2`, so there aren't interruptions before
  // working on `part1()`.
  func part2() -> Any {
    "Not implemented yet"
  }

  /// An initializer that loads the test data from the corresponding data file.
  init() {
    self.init(data: Self.loadData(challengeYear: Self.year, challengeDay: Self.day))
  }

  static func loadData(challengeYear: Int, challengeDay: Int) -> String {
    let dayString = String(format: "%02d", challengeDay)
    let dataFilename = "Day\(dayString)"
    let dataURL = Bundle.module.url(
      forResource: dataFilename,
      withExtension: "txt",
      subdirectory: "Resources/\(challengeYear)")

    guard let dataURL,
          let data = try? String(contentsOf: dataURL, encoding: .utf8)
    else {
      fatalError("Couldn't find file '\(dataFilename).txt' in the 'Resources/\(challengeYear)' directory.")
    }

    // On Windows, line separators may be CRLF. Converting to LF so that \n
    // works for string parsing.
    return data.replacingOccurrences(of: "\r", with: "")
  }
}
