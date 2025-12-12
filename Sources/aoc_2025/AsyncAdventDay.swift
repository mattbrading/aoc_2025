import ArgumentParser
import Foundation

protocol AsyncAdventDay: AsyncParsableCommand {
  var inputFile: String { get set }

  associatedtype Part1Result: CustomStringConvertible
  func part1(input: String) async -> Part1Result

  associatedtype Part2Result: CustomStringConvertible
  func part2(input: String) async -> Part2Result

}

extension AsyncAdventDay {

  mutating func run() async throws {
    let inputFileURL = URL(fileURLWithPath: inputFile)
    let input = try String(contentsOf: inputFileURL, encoding: .utf8)

    let clock = ContinuousClock()

    var part1result: Any?
    var part2result: Any?

    let part1time = await clock.measure {
      part1result = await part1(input: input)
    }

    print("Part 1: \(part1result!), Time: \(part1time)")

    let part2time = await clock.measure {
      part2result = await part2(input: input)
    }

    print("Part 2: \(part2result!), Time: \(part2time)")
  }

}
