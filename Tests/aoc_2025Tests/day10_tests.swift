import Testing

@testable import aoc_2025

@Suite("Day 10 Tests")
struct Day10Tests {

  let exampleInput = """
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    """

  @Test func part1() async throws {
    let result = Day10().part1(input: exampleInput)

    #expect(result == 7)
  }

  @Test func part2() async throws {
    let result = Day10().part2(input: exampleInput)

    #expect(result == 0)
  }
}
