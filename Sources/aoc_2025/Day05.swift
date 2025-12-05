import ArgumentParser
import Foundation

struct Day05: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day5")

  @Argument() var inputFile: String

  private func parseInput(input: String) -> (ranges: RangeSet<Int>, products: [Int]) {
    let sections = input.split(separator: "\n\n")
    let ranges = RangeSet<Int>(
      sections.first!.split(separator: "\n")
        .map({ line in
          let bounds = line.split(separator: "-")
          return Int(bounds.first!)!..<Int(bounds.last!)! + 1
        }))

    let products = sections.last!.split(separator: "\n").map({ Int($0)! })

    return (ranges, products)
  }

  func part1(input: String) -> Int {
    let (ranges, products) = parseInput(input: input)

    return products.filter({ ranges.contains($0) }).count
  }

  func part2(input: String) -> Int {
    let (ranges, _) = parseInput(input: input)

    return ranges.ranges.reduce(0) { acc, range in
      acc + range.count
    }
  }
}
