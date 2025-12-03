import Testing

@testable import aoc_2025

@Suite("Day 3 Tests")
struct Day03Tests {

  let exampleInput = """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """

  @Test func part1() async throws {
    let result = Day03().part1(input: exampleInput)

    #expect(result == 357)
  }

  @Test func part1_specifictests() async throws {
    let result = Day03().part1(input: "8466474564396658667")

    #expect(result == 98)
  }
}
