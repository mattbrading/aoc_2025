import Testing

@testable import aoc_2025

@Suite("Day 2 Tests")
struct Day02Tests {

  let exampleInput = """
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
    1698522-1698528,446443-446449,38593856-38593862,565653-565659,
    824824821-824824827,2121212118-2121212124
    """.split(separator: "\n").joined()

  @Test func part1() async throws {
    let result = Day02().part1(input: exampleInput)

    #expect(result == 1_227_775_554)
  }
}
