import ArgumentParser

@main
struct AoC2025: ParsableCommand {

  static let configuration = CommandConfiguration(
    commandName: "aoc_2025",
    abstract: "Run AoC 2025",
    subcommands: [
      Day01.self,
      Day02.self,
      Day03.self,
      Day04.self,
      Day05.self,
    ]
  )
}
