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

    var total = 0

    for id in possibleIds {
      for range in ranges {
        if range.contains(id) {
          total += id
        }
      }
    }
    
    return total
  }

  func part2(input: String) -> Int {

    var possibleIds = Set<Int>()

    (1...99999).forEach({ base in
    (2...5).forEach({repeats in 
      let possibleId = repeatElement(String(base), count: repeats).joined()
      if (possibleId.count <= 10) {
        possibleIds.insert(Int(possibleId)!)
      }
    })})

    let ranges = parseInput(input: input)

    var total = 0

    for id in possibleIds {
      for range in ranges {
        if range.contains(id) {
          total += id
        }
      }
    }

    return total
  }
}
