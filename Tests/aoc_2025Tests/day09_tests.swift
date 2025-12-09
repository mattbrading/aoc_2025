import Testing

@testable import aoc_2025

@Suite("Day 09 Tests")
struct Day09Tests {

  let exampleInput = """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """

  @Test func part1() async throws {
    let result = Day09().part1(input: exampleInput)

    #expect(result == 50)
  }

  @Test func part2() async throws {
    let result = Day09().part2(input: exampleInput)

    #expect(result == 24)
  }
}
