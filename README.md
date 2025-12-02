# Advent of Code Swift Starter Project

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

Daily programming puzzles at [Advent of Code](<https://adventofcode.com/>), by
[Eric Wastl](<http://was.tl/>). This is a small example starter project for
building Advent of Code solutions.

## Usage

Swift comes with Xcode, or you can [install it](https://www.swift.org/install/)
on a supported macOS, Linux, or Windows platform. 

If you're using Xcode, you can open this project by choosing File / Open and
select the parent directory. 

If you prefer the command line, you can run the test suite with `swift test`,
and run the output with `swift run`.

If you're using Visual Studio Code to edit, you might find these Swift
extensions useful:

- [Swift](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang)
  (provides core language edit / debug / test features)
- [apple-swift-format](https://marketplace.visualstudio.com/items?itemName=vknabel.vscode-apple-swift-format)
  (supports the [swift-format](https://github.com/apple/swift-format) package)

## Challenges

Challenges are organized by year. Each year has its own directory with source files and data:

```
Sources/
├── 2024/
│   ├── Day01_2024.swift
│   └── Day02_2024.swift
├── 2025/
│   └── Day01_2025.swift
├── Resources/
│   ├── 2024/
│   │   ├── Day01.txt
│   │   └── Day02.txt
│   └── 2025/
│       └── Day01.txt
├── AdventChallenge.swift
└── AdventOfCode.swift
```

To start a new day's challenge:

1. Create the source file `Sources/{year}/Day{XX}_{year}.swift` (e.g., `Day01_2024.swift`)
2. Add your input data to `Sources/Resources/{year}/Day{XX}.txt`
3. Register the challenge type in `AdventOfCode.swift`

Each challenge struct should conform to `AdventChallenge` and specify its year:

```swift
struct Day01_2024: AdventChallenge {
    static var year: Int { 2024 }
    var data: String

    func part1() -> Any { ... }
    func part2() -> Any { ... }
}
```

The `AdventOfCode.swift` file controls which challenge is run with `swift run`.
By default it runs the most recent challenge for the default year.

To supply command line arguments use `swift run AdventOfCode`. For example:
- `swift run AdventOfCode 3` runs day 3 of the default year
- `swift run AdventOfCode --year 2024 3` runs day 3 of 2024
- `swift run -c release AdventOfCode --benchmark 3` builds with full optimizations and benchmarks day 3

## Linting and Formatting

Challenge source code can be linted and formatted automatically using the
included dependency on `swift-format`.

Lint source code with the following command:

```shell
$ swift package lint-source-code
```

Format source code with the following command:

```shell
$ swift package format-source-code
Plugin ‘Format Source Code’ wants permission to write to the package directory.
Stated reason: “This command formats the Swift source files”.
Allow this plugin to write to the package directory? (yes/no)
```

To avoid the interactive prompt when formatting source code, use the 
`--allow-writing-to-package-directory` flag.
 
```shell
$ swift package format-source-code --allow-writing-to-package-directory
```

swift-format will use the built-in default style to lint and format code. A
`.swift-format` configuration file can be used to customize the style used, see
[Configuration](https://github.com/apple/swift-format/blob/main/Documentation/Configuration.md)
for more details. 
