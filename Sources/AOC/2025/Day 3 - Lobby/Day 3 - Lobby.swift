struct Day_3_Lobby: Solution {
    var day: Int { 3 }
    var year: Int { 2025 }

    var testInputPath: String { "Inputs/2025_3.txt" }

    func part1(input: String) async -> String {
        let banks = parse(input: input)

        return
            banks
            .map { $0.maxJoltage(forBatteries: 2) }
            .sum()
            .description
    }

    func part2(input: String) async -> String {
        let banks = parse(input: input)

        return
            banks
            .map { $0.maxJoltage(forBatteries: 12) }
            .sum()
            .description
    }

    func parse(input: String) -> [Bank] {
        input
            .split(separator: "\n")
            .map { Bank(batteries: String($0)) }
    }
}

struct Bank {
    let batteries: String

    init(batteries: String) {
        self.batteries = batteries
    }

    func maxJoltage(forBatteries: Int) -> Int {
        var joltages = batteries.compactMap { Int(String($0)) }
        var removalCount = joltages.count - forBatteries
        var stack: [Int] = []

        while joltages.count > 0 {

            let joltage = joltages.removeFirst()

            // Always add the first battery
            if stack.isEmpty {
                stack.append(joltage)
                continue
            }

            var lastJoltage = stack.last!
            if joltage > lastJoltage && removalCount > 0 {
                // Remove batteries until we can add the current one
                while joltage > lastJoltage && removalCount > 0 && !stack.isEmpty {
                    _ = stack.removeLast()
                    lastJoltage = stack.last ?? 0
                    removalCount -= 1
                }

                stack.append(joltage)
                continue
            } else if stack.count < forBatteries {
                // Just add the battery
                stack.append(joltage)
                continue
            }

            // Can't add the battery, skip it
            if stack.count == forBatteries {
                removalCount -= 1
            }
        }

        return Int(stack.concat()) ?? 0
    }

}
