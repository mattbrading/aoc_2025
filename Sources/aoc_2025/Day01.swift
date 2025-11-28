import ArgumentParser
import Foundation

struct Day01: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day1")

  @Argument() var inputFile: String

  func part1(input: String) -> String {
    return input + " part 1"
  }

  func part2(input: String) -> String {
    return input + " part 2"
  }
}
