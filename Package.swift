// swift-tools-version:6.2
import PackageDescription

let name = "AOC"
let package = Package(
  name: name,
  platforms: [.macOS(.v12)],
  targets: [
    .executableTarget(name: name)
  ]
)