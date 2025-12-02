import ArgumentParser
import Foundation

struct Day02: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day2")

  @Argument() var inputFile: String

  func parseInput(input: String) -> [ClosedRange<Int>] {
    return input.split(separator: ",")
      .map({ range in
        let range = range.split(separator: "-")

        return max(11, Int(range.first!)!)...Int(range.last!)!
      })
  }

  func part1(input: String) -> Int {
    let ranges = parseInput(input: input)

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
    let ranges = parseInput(input: input)

    let sumInvalidIds = ranges.reduce(0) { runningTotal, range in
      return range.reduce(runningTotal) { runningTotal, id in
        let idStr = String(id)

        let divisors = (1...idStr.count / 2)
          .filter({ idStr.count % $0 == 0 })

        let isInvalidId = divisors.contains { divisor in
          let splitPoint = idStr.index(idStr.startIndex, offsetBy: divisor)

          let repeated = repeatElement(idStr[..<splitPoint], count: idStr.count / divisor)
            .joined()

          return idStr == repeated
        }

        return isInvalidId
          ? runningTotal + id
          : runningTotal
      }
    }

    return sumInvalidIds
  }
}
