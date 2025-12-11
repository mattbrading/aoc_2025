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
    let possibleIds: [Int] = (1...99999).map({ Int(String($0) + String($0))! })

    let ranges = parseInput(input: input)

    return possibleIds.reduce(0) { outerTotal, id in
      outerTotal
        + ranges.reduce(0) { innerTotal, range in
          range.contains(id) ? innerTotal + id : innerTotal
        }
    }
  }

  func part2(input: String) -> Int {

    let possibleIds = Set(
      (1...99999).flatMap({ base in
        let maxRepeats = 10 / (Int(floor(log10(Double(base)))) + 1)
        return (2...maxRepeats).compactMap({ repeats in
          let possibleId = repeatElement(String(base), count: repeats).joined()
          return Int(possibleId)
        })
      }))

    let ranges = parseInput(input: input)

    return possibleIds.reduce(0) { outerTotal, id in
      outerTotal
        + ranges.reduce(0) { innerTotal, range in
          range.contains(id) ? innerTotal + id : innerTotal
        }
    }
  }
}
