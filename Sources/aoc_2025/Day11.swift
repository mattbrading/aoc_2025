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

  fileprivate func findPaths(from: String, map: [String: Set<String>]) -> Int {
    if map[from]!.contains("out") { return 1 }

    return map[from]!.reduce(0) { total, nextNode in
      total + findPaths(from: nextNode, map: map)
    }
  }

  func part1(input: String) -> Int {
    let map = parseInput(input: input)

    return findPaths(from: "you", map: map)
  }

  func part2(input: String) -> Int {
    let map = parseInput(input: input)

    struct CacheKey: Hashable {
      let node: String
      let dac: Bool
      let fft: Bool
    }
    var cache: [CacheKey: Int] = [:]

    func findPaths(node: String, dac: Bool, fft: Bool, map: [String: Set<String>]) -> Int {
      let cacheKey = CacheKey(node: node, dac: dac, fft: fft)

      if let cached = cache[cacheKey] { return cached }

      if map[node]!.contains("out") { return dac && fft ? 1 : 0 }

      let dac = dac || node == "dac"
      let fft = fft || node == "fft"

      let result = map[node]!.reduce(0) { total, nextNode in
        return total + findPaths(node: nextNode, dac: dac, fft: fft, map: map)
      }

      cache[cacheKey] = result

      return result
    }

    return findPaths(node: "svr", dac: false, fft: false, map: map)
  }
}
