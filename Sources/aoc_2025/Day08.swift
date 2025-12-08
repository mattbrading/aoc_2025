import ArgumentParser
import Collections
import Foundation

private struct Point: Hashable, CustomDebugStringConvertible {
  let x: Double
  let y: Double
  let z: Double

  init(fromString string: String.SubSequence) {
    let components = string.split(separator: ",")
    x = Double(components[0])!
    y = Double(components[1])!
    z = Double(components[2])!
  }

  func distance(from point: Point) -> Double {
    return sqrt(
      pow(point.x - x, 2) + pow(point.y - y, 2) + pow(point.z - z, 2)
    )
  }

  var debugDescription: String {
    "\(x),\(y),\(z)"
  }
}

struct Day08: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day8")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    part1(input: input, maxPairs: 1000)
  }

  func part1(input: String, maxPairs: Int) -> Int {
    let points = input.split(separator: "\n")
      .map({ Point(fromString: $0) })

    var distances = OrderedDictionary<Double, (Point, Point)>()

    points.enumerated().forEach({ index, point in
      points[(index + 1)...].forEach({ distances[point.distance(from: $0)] = (point, $0) })
    })

    distances.sort()

    let closestPairs = distances.keys[..<maxPairs]
      .map({ distances[$0]! })

    let circuits: [Set<Point>] = closestPairs.reduce([]) { circuits, pair in
      var newCircuit = Set([pair.0, pair.1])

      circuits.filter({ !$0.isDisjoint(with: newCircuit) })
        .forEach({ newCircuit.formUnion($0) })

      var newCircuits = circuits.filter({ $0.isDisjoint(with: newCircuit) })

      newCircuits.append(newCircuit)

      return newCircuits
    }

    return circuits.map({ $0.count }).sorted().reversed()[0..<3].reduce(1) { $0 * $1 }
  }

  func part2(input: String) -> Int {
    0
  }
}
