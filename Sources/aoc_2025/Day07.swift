import ArgumentParser
import Foundation

extension Substring {

  fileprivate func getRelativeOffset(of: Character) -> Int? {
    guard let charIndex = self.firstIndex(of: of) else {
      return nil
    }

    return self.distance(from: self.startIndex, to: charIndex)
  }

  fileprivate func getCharacterAtOffset(of: Int) -> Character? {
    let index = self.index(self.startIndex, offsetBy: of)

    if !self.indices.contains(index) {
      return nil
    }

    return self[index]
  }

}

struct Day07: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day7")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    let lines = input.split(separator: "\n")

    let startPoint = lines.first!.getRelativeOffset(of: "S")!

    let (_, splits): (Set<Int>, Int) = lines[1...].reduce(
      (Set([startPoint]), 0),
      { state, line in
        var (beams, splits) = state

        beams = Set(
          beams.flatMap({ beam -> [Int] in
            if line.getCharacterAtOffset(of: beam) == "^" {
              splits += 1
              return [beam - 1, beam + 1]
            }
            return [beam]
          }))

        return (beams, splits)
      })

    return splits
  }

  func part2(input: String) -> Int {
    0
  }
}
