import ArgumentParser
import Foundation

struct Day02: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day2")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    let ranges = input.split(separator: ",")
      .map({ range in
        let range = range.split(separator: "-")

        return Int(range.first!)!...Int(range.last!)!
      })

    let sumInvalidIds = ranges.reduce(0) { runningTotal, range in
      return range.reduce(runningTotal) { runningTotal, id in
        let idStr = String(id)

        let halfway = idStr.index(idStr.startIndex, offsetBy: idStr.count / 2)

        return idStr[..<halfway] == idStr[halfway...] ? runningTotal + id : runningTotal

      }
    }
    return sumInvalidIds
  }

  func part2(input: String) -> Int {
    return 0
  }
}
