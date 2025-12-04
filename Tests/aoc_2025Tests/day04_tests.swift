import Testing

@testable import aoc_2025

@Suite("Day 4 Tests")
struct Day04Tests {

  let exampleInput = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

  @Test func part1() async throws {
    let result = Day04().part1(input: exampleInput)

    #expect(result == 13)
  }
}
