import Testing

@testable import aoc_2025

@Suite("Day 06 Tests")
struct Day06Tests {

  let exampleInput = """
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   +  
    """

  @Test func part1() async throws {
    let result = Day06().part1(input: exampleInput)

    #expect(result == 4_277_556)
  }

  @Test func part2() async throws {
    let result = Day06().part2(input: exampleInput)

    #expect(result == 0)
  }
}
