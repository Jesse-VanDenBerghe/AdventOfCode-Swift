import Foundation

public protocol Solution: Sendable {
    var day: Int { get }
    var year: Int { get }

    func part1(input: String) -> String
    func part2(input: String) -> String
}

extension Solution {
    var testInput: String {
        let url = URL(fileURLWithPath: "Sources/AOC/\(year)/day\(day)/\(year)_\(day).txt")

        return try! String(contentsOf: url)
    }
}

class SolutionRegistry {
    static let year2025: [Solution] = [
        Day_1_Secret_Entrance()
    ]

    static let solutions: [Solution] = year2025
    
    static func get(day: Int, year: Int) -> Solution? {
        solutions.first { $0.day == day && $0.year == year }
    }
}