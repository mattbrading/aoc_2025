import ArgumentParser
import Foundation

struct Day03: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day3")

  @Argument() var inputFile: String

  func parseInput(input: String) -> [[Int]] {
    return input.split(separator: "\n").map({ bank in
      bank.map({ $0.wholeNumberValue! })
    })
  }

  func part1(input: String) -> Int {
    let banks = parseInput(input: input)

    return banks.reduce(0) { runningTotal, bank in

      let a = bank.max()!
      let aIdx = bank.firstIndex(of: a)!

      let searchRange = aIdx == bank.endIndex - 1 ? bank[..<aIdx] : bank[(aIdx + 1)...]

      let b = searchRange.max()!
      let bIdx = searchRange.firstIndex(of: b)!

      let maxJoltage = aIdx > bIdx ? b * 10 + a : a * 10 + b

      return runningTotal + maxJoltage
    }
  }

  func findMaxJoltage(bank: [Int], minLength: Int) -> Int {
    if minLength == 1 {
      return bank.max()!
    }

    let searchRange = bank[...(bank.endIndex - minLength)]

    let nextDigit = searchRange.max()!
    let nextDigitIdx = bank.firstIndex(of: nextDigit)!

    let remainingDigits = Array(bank[(nextDigitIdx + 1)...])

    return Int(
      String(nextDigit) + String(findMaxJoltage(bank: remainingDigits, minLength: minLength - 1)))!
  }

  func part2(input: String) -> Int {
    let banks = parseInput(input: input)
    return banks.reduce(0) { runningTotal, bank in
      let maxJoltage = findMaxJoltage(bank: bank, minLength: 12)
      return runningTotal + maxJoltage
    }
  }
}
