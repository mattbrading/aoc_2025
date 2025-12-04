import ArgumentParser
import Foundation

private struct Location: Hashable, CustomDebugStringConvertible {
  let row: Int
  let col: Int

  var debugDescription: String { "(\(row), \(col))" }

  var neighbours: [Location] {
    [
      Location(row: row - 1, col: col - 1),
      Location(row: row - 1, col: col),
      Location(row: row - 1, col: col + 1),
      Location(row: row, col: col - 1),
      Location(row: row, col: col + 1),
      Location(row: row + 1, col: col - 1),
      Location(row: row + 1, col: col),
      Location(row: row + 1, col: col + 1),
    ]
  }
}

struct Day04: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day4")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {

    let rolls = Set(
      input.split(separator: "\n").enumerated().flatMap({ rowIdx, row in
        row.enumerated().compactMap({ colIdx, col in
          return col == "@" ? Location(row: rowIdx, col: colIdx) : nil
        })
      }))

    return rolls.filter({ roll in
      roll.neighbours.filter({ rolls.contains($0) }).count < 4
    }).count
  }

  func part2(input: String) -> Int {
    0
  }
}
