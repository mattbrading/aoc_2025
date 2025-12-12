import ArgumentParser
import Foundation

struct Day12: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day12")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    let parts = input.split(separator: "\n\n")

    let presents = parts[..<(parts.endIndex - 1)]
      .map({ presLine in
        presLine.count(where: { $0 == "#" })
      })

    let regions = parts.last!.components(separatedBy: .newlines)

    let validRegions = regions.filter { region in
      let sections = region.split(separator: ": ", maxSplits: 1)

      let area = sections.first!.split(separator: "x").compactMap({ Int($0) })
        .reduce(1) { $0 * $1 }

      let presentsCounts = sections.last!.components(separatedBy: .whitespaces).compactMap({
        Int($0)
      })

      let presentsArea = presentsCounts.enumerated().reduce(0) { total, current in
        total + (presents[current.offset] * current.element)
      }

      return area > presentsArea
    }

    return validRegions.count
  }

  func part2(input: String) -> Int {
    0
  }
}
