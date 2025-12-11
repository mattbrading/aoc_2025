import ArgumentParser
import Foundation

private struct Location: Hashable, CustomDebugStringConvertible {
  let row: Int
  let col: Int

  var debugDescription: String { "(\(row), \(col))" }

  var neighbours: Set<Location> {
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

  private func parseInput(input: String) -> Set<Location> {
    return Set(
      input.split(separator: "\n").enumerated().flatMap({ rowIdx, row in
        row.enumerated().compactMap({ colIdx, col in
          return col == "@" ? Location(row: rowIdx, col: colIdx) : nil
        })
      }))
  }

  func part1(input: String) -> Int {
    let rolls = parseInput(input: input)

    return rolls.filter({ roll in
      roll.neighbours.intersection(rolls).count < 4
    }).count
  }

  private func checkRolls(rolls: Set<Location>, toCheck: Set<Location>? = nil) -> Int {
    let toRemove = (toCheck ?? rolls).filter({ roll in
      roll.neighbours.intersection(rolls).count < 4
    })

    if toRemove.isEmpty { return 0 }

    let newMap = rolls.subtracting(toRemove)
    let toCheck = Set(toRemove.flatMap({ $0.neighbours })).intersection(newMap)

    return toRemove.count + checkRolls(rolls: newMap, toCheck: toCheck)
  }

  func part2(input: String) -> Int {
    let rolls = parseInput(input: input)

    return checkRolls(rolls: rolls)
  }
}
