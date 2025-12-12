import ArgumentParser
import Foundation
import Subprocess

private struct Machine {
  let target: [Int: Bool]
  let buttons: [Set<Int>]
  let joltage: [Int]
}

func invokeZ3(input: String) async throws -> Int {
  let result = try await run(
    .name("z3"), arguments: ["-in"], input: .string(input), output: .string(limit: 4096))

  let lines = result.standardOutput!.components(separatedBy: .newlines)
    .compactMap({ line in
      let match = try! /^\s+([0-9]+)\)$/.firstMatch(in: line)?.output.1
      return match != nil ? Int(match!) : nil
    })

  return lines.reduce(0) { $0 + $1 }
}

struct Day10: AsyncAdventDay {
  static let configuration = CommandConfiguration(commandName: "day10")

  @Argument() var inputFile: String

  fileprivate func parseInput(input: String) -> [Machine] {
    input.components(separatedBy: .newlines).map({ line in
      let parts = line.components(separatedBy: .whitespaces)

      let target = Dictionary(
        uniqueKeysWithValues: parts.first!.filter({ $0 == "#" || $0 == "." })
          .enumerated().map({ idx, char in (idx, char == "#") }))

      let buttons = parts[(parts.startIndex + 1)..<(parts.endIndex - 1)]
        .map { button in
          Set(button.components(separatedBy: .punctuationCharacters).compactMap({ Int($0) }))
        }

      let joltage = parts.last!
        .components(separatedBy: .punctuationCharacters).compactMap({ Int($0) })

      return Machine(target: target, buttons: buttons, joltage: joltage)
    })
  }

  func part1(input: String) -> Int {
    let machines = parseInput(input: input)

    return machines.reduce(0) { runningTotal, machine in
      var nodes = Set(machine.buttons.map({ Set([$0]) }))
      var buttonPresses: Int? = nil

      while !nodes.isEmpty {

        for checking in nodes {
          if machine.target.allSatisfy({ idx, aim in
            aim == checking.reduce(false) { state, button in button.contains(idx) ? !state : state }
          }) {
            buttonPresses = checking.count
            break
          }
        }

        if buttonPresses != nil {
          break
        }

        for node in nodes {
          nodes.remove(node)
          for button in machine.buttons {
            nodes.insert(node.union([button]))
          }
        }
      }

      return runningTotal + buttonPresses!
    }
  }

  func part2(input: String) async -> Int {

    let machines = parseInput(input: input)

    var result = 0

    for machine in machines {
      let args = machine.buttons.indices.map({ "n\($0)" })

      var z3Input: [String] = []

      // Variables
      args.forEach({ z3Input.append("(declare-fun \($0) () Int)") })

      // Assertions
      args.forEach({ z3Input.append("(assert (>= \($0) 0))") })
      machine.joltage.enumerated().forEach({ jIdx, joltage in
        let buttons = machine.buttons.enumerated().compactMap({ bIdx, button in
          button.contains(jIdx) ? args[bIdx] : nil
        })

        z3Input.append("(assert (= (+ \(buttons.joined(separator: " "))) \(joltage)))")
      })

      z3Input.append("(minimize (+ \(args.joined(separator: " "))))")

      z3Input.append("(check-sat)")
      z3Input.append("(get-model)")

      let buttonPresses = try! await invokeZ3(input: z3Input.joined(separator: "\n"))

      result += buttonPresses

    }

    return result
  }
}
