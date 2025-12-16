import Foundation

struct Day_2_Gift_Shop: Solution {
    var day: Int { 2 }
    var year: Int { 2025 }

    var testInputPath: String { "Inputs/2025_2.txt" }

    func part1(input: String) async -> String {
        var invalidIds: Set<Int> = []
        let ranges = parse(input: input)

        ranges.forEachItemInRanges({ item in
            if item.isRepeatingTwice() {
                invalidIds.insert(Int(item)!)
            }
        })

        return invalidIds.sum().description
    }

    func part2(input: String) async -> String {
        var invalidIds: Set<Int> = []
        let ranges = parse(input: input)

        ranges.forEachItemInRanges({ item in
            if item.isRepeatingMultipleTimes() {
                invalidIds.insert(Int(item)!)
            }
        })

        return invalidIds.sum().description
    }

    func parse(input: String) -> [StringRange] {
        input
            .split(separator: ",")
            .map { line in
                let parts = line.split(separator: "-")
                return StringRange(from: String(parts[0]), to: String(parts[1]))
            }
    }
}
