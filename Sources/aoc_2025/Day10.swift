import ArgumentParser
import Foundation

private struct Machine {
  let target: [Int: Bool]
  let buttons: [Set<Int>]
  let joltage: [Int]
}

struct Day10: AdventDay {
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

  func part2(input: String) -> Int {

    let machines = parseInput(input: input)

    return machines.reduce(0) { runningTotal, machine in

      let wiresByButton = machine.joltage.indices.map({ idx in
        machine.buttons.count(where: { $0.contains(idx) })
      })

      print("wires", wiresByButton)

      let buttonMaxPresses = machine.buttons.map({ button in
        button.map({ machine.joltage[$0] }).min()!
      })

      print("maxPresses", buttonMaxPresses)

      let buttonMinPresses = machine.buttons.map({ button in
        button.map({ wiresByButton[$0] == 1 ? machine.joltage[$0] : 0 }).max()!
      })

      print("minPresses", buttonMinPresses)

      return runningTotal
    }
  }
}
