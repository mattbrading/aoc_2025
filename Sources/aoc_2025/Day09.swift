import ArgumentParser
import Foundation

private struct Point: Hashable, CustomDebugStringConvertible {
  let col: Int
  let row: Int

  var debugDescription: String {
    "(\(col),\(row))"
  }
}

struct Day09: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day9")

  @Argument() var inputFile: String

  fileprivate func parseInput(input: String) -> [Point] {
    input.components(separatedBy: .newlines)
      .map({ line in
        let coords = line.split(separator: ",")
        return Point(col: Int(coords.first!)!, row: Int(coords.last!)!)
      })
  }

  func part1(input: String) -> Int {
    let points = parseInput(input: input)

    let areas = points.enumerated().flatMap({ idx, point in
      points[(idx + 1)...].map({ (1 + abs(point.col - $0.col)) * (1 + abs(point.row - $0.row)) })
    })

    return areas.max()!
  }

  func part2(input: String) -> Int {
    let points = parseInput(input: input)

    var rows: [Int: RangeSet<Int>] = points.enumerated().reduce([:]) { rows, point in
      var rows = rows

      let (idx, point) = point

      let nextIdx = idx == (points.endIndex - 1) ? 0 : idx + 1
      let nextPoint = points[nextIdx]

      (min(point.row, nextPoint.row)...max(point.row, nextPoint.row)).forEach({ row in
        rows[row] = rows[row] ?? RangeSet()
        rows[row]!.insert(contentsOf: (min(point.col, nextPoint.col)..<(max(point.col, nextPoint.col) + 1)))
      })
      return rows
    }

    rows.forEach({ key, value in 
      let filledRow = stride(from: 0, to: value.ranges.count, by: 2).map({ idx in
        idx + 1 == value.ranges.count ? value.ranges[idx] : value.ranges[idx].lowerBound..<value.ranges[idx+1].upperBound
      })

      rows[key] = RangeSet(filledRow)
    })

    let areas = points.enumerated().flatMap({ idx, pointA in
      points[(idx + 1)...].compactMap({ pointB in
        let rowRange = (min(pointA.row, pointB.row)..<max(pointA.row, pointB.row)+1)
        let colRange = (min(pointA.col, pointB.col)..<max(pointA.col, pointB.col)+1)
        let area = rowRange.count * colRange.count
        
        return (area, rowRange, colRange)
      })
    })

    return areas.sorted(by: { $0.0 > $1.0 }).first(where: { _, rowRange, colRange in
      rows[rowRange.lowerBound]!.isSuperset(of: RangeSet(colRange)) &&
      rows[rowRange.upperBound - 1]!.isSuperset(of: RangeSet(colRange)) &&
      rowRange.allSatisfy({ rows[$0]!.contains(colRange.lowerBound) && rows[$0]!.contains(colRange.upperBound - 1)})
    })!.0
  }
}
