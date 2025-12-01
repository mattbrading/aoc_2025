import Testing

@testable import aoc_2025

@Suite("Day 1 Tests")
struct Day01Tests {

  let exampleInput = """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

  @Test func part1() async throws {
    let result = Day01().part1(input: exampleInput)

    #expect(result == 3)
  }

  @Test func part2() async throws {
    let result = Day01().part2(input: exampleInput)

    #expect(result == 6)
  }

  @Test func part2_extreme() async throws {
    let input = """
      L1000
      R1000
      """

    let result = Day01().part2(input: input)

    #expect(result == 20)
  }
}
