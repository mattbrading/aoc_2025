import ArgumentParser
import Foundation

struct Day09: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day9")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    let points = input.components(separatedBy: .newlines)
      .map({ line in
        let coords = line.split(separator: ",")
        return (Int(coords.first!)!, Int(coords.last!)!)
      })

    let areas = points.enumerated().flatMap({ idx, point in
      points[(idx + 1)...].map({ (1 + abs(point.0 - $0.0)) * (1 + abs(point.1 - $0.1)) })
    })

    return areas.max()!
  }

  func part2(input: String) -> Int {
    0
  }
}
