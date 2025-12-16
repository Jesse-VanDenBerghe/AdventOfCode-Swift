import Foundation

public protocol Solution: Sendable {
    var day: Int { get }
    var year: Int { get }

    var testInputPath: String { get}

    func part1(input: String) async -> String
    func part2(input: String) async -> String
}

extension Solution {
    var testInput: String {
        let url = URL(fileURLWithPath: testInputPath)
        do {
            return try String(contentsOf: url)
        } catch {
            fatalError("Could not load test input at path: \(testInputPath)")
        }
    }
}

class SolutionRegistry {
    static let year2025: [Solution] = [
        Day_1_Secret_Entrance(),
        Day_2_Gift_Shop(),
    ]

    static let solutions: [Solution] = year2025
    
    static func get(day: Int, year: Int) -> Solution? {
        solutions.first { $0.day == day && $0.year == year }
    }
}