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

private struct Distances {
  var distances: Heap<Double> = Heap()
  var map: [Double: (Point, Point)] = [:]

  mutating func insert(distance: Double, pair: (Point, Point)) {
    distances.insert(distance)
    map[distance] = pair
  }

  mutating func getNextClosest() -> (Point, Point) {
    return self.map[self.distances.removeMin()]!
  }
}

struct Day08: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day8")

  @Argument() var inputFile: String

  fileprivate func parseInput(input: String) -> [Point] {
    input.split(separator: "\n")
      .map({ Point(fromString: $0) })
  }

  fileprivate func getDistances(points: [Point]) -> Distances {
    var distances = Distances()

    points.enumerated().forEach({ index, point in
      points[(index + 1)...].forEach({
        distances.insert(distance: point.distance(from: $0), pair: (point, $0))
      })
    })

    return distances
  }

  fileprivate func findNewCircuits(newPair: (Point, Point), circuits: [Set<Point>]) -> [Set<Point>]
  {
    var newCircuit = Set([newPair.0, newPair.1])

    circuits.filter({ !$0.isDisjoint(with: newCircuit) })
      .forEach({ newCircuit.formUnion($0) })

    var newCircuits = circuits.filter({ $0.isDisjoint(with: newCircuit) })

    newCircuits.append(newCircuit)

    return newCircuits
  }

  func part1(input: String) -> Int {
    part1(input: input, maxPairs: 1000)
  }

  func part1(input: String, maxPairs: Int) -> Int {
    let points = parseInput(input: input)
    var distances = getDistances(points: points)

    let closestPairs = (0..<maxPairs).map({ _ in distances.getNextClosest() })

    let circuits: [Set<Point>] = closestPairs.reduce([]) { circuits, pair in
      findNewCircuits(newPair: pair, circuits: circuits)
    }

    return circuits.map({ $0.count }).sorted().reversed()[0..<3].reduce(1) { $0 * $1 }
  }

  func part2(input: String) -> Int {
    let points = parseInput(input: input)
    var distances = getDistances(points: points)

    var circuits: [Set<Point>] = []
    var lastPair: (Point, Point)? = nil

    while circuits.first?.count != points.count {
      lastPair = distances.getNextClosest()

      circuits = findNewCircuits(newPair: lastPair!, circuits: circuits)
    }

    return Int(lastPair!.0.x) * Int(lastPair!.1.x)
  }
}
