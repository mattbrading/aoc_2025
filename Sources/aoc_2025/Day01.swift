import ArgumentParser
import Foundation

struct Day01: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day1")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {

    let lines = input.split(separator: "\n")
      .compactMap({ line in
        var line = String(line)
        let dir = line.remove(at: line.startIndex) == "R" ? 1 : -1
        let dis = Int(line)!
        return dir * dis
      })

    var zeroes = 0

    _ = lines.reduce(50) { pos, mov in
      var newPos = (pos + mov) % 100
      newPos = newPos >= 0 ? newPos : 100 + newPos
      if newPos == 0 { zeroes += 1 }
      return newPos
    }

    return zeroes
  }

  func part2(input: String) -> String {
    return ""
  }
}
