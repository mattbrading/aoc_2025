import ArgumentParser
import Foundation

struct Day06: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day6")

  @Argument() var inputFile: String

  func part1(input: String) -> Int {
    let rows = input.split(separator: "\n")
      .map({ line in
        return line.split(separator: /\s+/)
      })

    let cols = (0..<rows.first!.endIndex).map({ colIdx in
      rows.map({ $0[colIdx] })
    })

    return cols.reduce(0) { runningTotal, column in
      let method = column.last!
      let digits = column.compactMap({ Int($0) })

      let colResult =
        (method == "+")
        ? digits.reduce(0) { $0 + $1 }
        : digits.reduce(1) { $0 * $1 }

      return runningTotal + colResult
    }
  }

  func part2(input: String) -> Int {
    let rows = input.split(separator: "\n").map({ String($0) })

    let cols = rows.first!.indices.map({ idx in
      rows.map({ $0[idx] })
    })

    typealias ReduceState = (Int, Int?, Character?)

    let result = cols.reduce(ReduceState(0, nil, nil)) {
      (state: ReduceState, col: [Character]) -> ReduceState in

      var (total, runningTotal, method) = state

      let colStr = String(col.filter({ $0.isNumber }))

      if colStr.isEmpty {
        return (total + (runningTotal ?? 0), nil, nil)
      }

      let num = Int(colStr)!

      method = method ?? col.last!

      runningTotal =
        method == "+"
        ? (runningTotal ?? 0) + num
        : (runningTotal ?? 1) * num

      return (total, runningTotal, method)
    }

    return result.0 + (result.1 ?? 0)
  }
}
