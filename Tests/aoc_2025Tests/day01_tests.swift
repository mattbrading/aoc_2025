import Testing

@testable import aoc_2025

@Suite("Day 1 Tests")
struct Day01Tests {

  let exampleInput = """
    example input
    """

  @Test func part1() async throws {
    let result = Day01().part1(input: exampleInput)

    #expect(result == "example input part 1")
  }

  @Test func part2() async throws {
    let result = Day01().part2(input: exampleInput)

    #expect(result == "example input part 2")
  }
}
