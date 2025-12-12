// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "aoc_2025",
  platforms: [.macOS(.v15)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser", from: "1.6.2"),
    .package(
      url: "https://github.com/apple/swift-collections.git",
      .upToNextMinor(from: "1.3.0")
    ),
    .package(url: "https://github.com/swiftlang/swift-subprocess.git", branch: "main"),
  ],
  targets: [
    .executableTarget(
      name: "aoc_2025",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Subprocess", package: "swift-subprocess"),
      ]
    ),
    .testTarget(
      name: "aoc_2025Tests",
      dependencies: ["aoc_2025"]
    ),
  ]
)
