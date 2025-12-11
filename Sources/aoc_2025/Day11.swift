import ArgumentParser
import Foundation

struct Day11: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day11")

  @Argument() var inputFile: String

  fileprivate func parseInput(input: String) -> [String: Set<String>] {
    let lines = input.components(separatedBy: .newlines).map({ line in
      let points = line.components(separatedBy: [" ", ":"]).filter({ !$0.isEmpty })
      return (points.first!, Set(points[1...]))
    })

    return Dictionary(uniqueKeysWithValues: lines)
  }

  fileprivate func findPaths(from: String, map: [String: Set<String>], visited: Set<String>) -> Int
  {
    var visited = visited
    visited.insert(from)

    if map[from]!.contains("out") { return 1 }

    return map[from]!.reduce(0) { total, nextNode in
      if visited.contains(nextNode) { return total }

      return total + findPaths(from: nextNode, map: map, visited: visited)
    }
  }

  func part1(input: String) -> Int {
    let map = parseInput(input: input)

    return findPaths(from: "you", map: map, visited: Set())
  }

  func part2(input: String) -> Int {
    0
  }
}
