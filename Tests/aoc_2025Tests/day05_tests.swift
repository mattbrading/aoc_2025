import Testing

@testable import aoc_2025

@Suite("Day 5 Tests")
struct Day05Tests {

  let exampleInput = """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

  @Test func part1() async throws {
    let result = Day05().part1(input: exampleInput)

    #expect(result == 3)
  }

  @Test func part2() async throws {
    let result = Day05().part2(input: exampleInput)

    #expect(result == 14)
  }
}
