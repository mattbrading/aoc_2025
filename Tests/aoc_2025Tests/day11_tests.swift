import Testing

@testable import aoc_2025

@Suite("Day 11 Tests")
struct Day11Tests {

  let exampleInput = """
    aaa: you hhh
    you: bbb ccc
    bbb: ddd eee
    ccc: ddd eee fff
    ddd: ggg
    eee: out
    fff: out
    ggg: out
    hhh: ccc fff iii
    iii: out
    """

  @Test func part1() async throws {
    let result = Day11().part1(input: exampleInput)

    #expect(result == 5)
  }

  let examplePart2 = """
    svr: aaa bbb
    aaa: fft
    fft: ccc
    bbb: tty
    tty: ccc
    ccc: ddd eee
    ddd: hub
    hub: fff
    eee: dac
    dac: fff
    fff: ggg hhh
    ggg: out
    hhh: out
    """

  @Test func part2() async throws {
    let result = Day11().part2(input: examplePart2)

    #expect(result == 2)
  }
}
