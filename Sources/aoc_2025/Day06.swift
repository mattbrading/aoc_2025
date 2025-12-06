import ArgumentParser
import Foundation

struct Day06: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day6")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    let rows = input.split(separator: "\n")
      .map({ line in
        return line.split(separator: /\s+/)
      })

    let cols = (0..<rows.first!.endIndex).map({ colIdx in
      rows.map({ $0[colIdx] })
    })

    return cols.reduce(0) { runningTotal, column in
      let method = column.last!
      let digits = column.compactMap({ Int($0) })

      let colResult =
        (method == "+")
        ? digits.reduce(0) { $0 + $1 }
        : digits.reduce(1) { $0 * $1 }

      return runningTotal + colResult
    }
  }

  func part2(input: String) -> Int {
    0
  }
}
