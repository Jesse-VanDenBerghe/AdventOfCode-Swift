import Foundation

Task {
    let args = Args()

    print(
        "₊˚｡⋆❆⋆｡˚₊ Year \(args.year) Day \(args.day) Part \(args.part.map(String.init) ?? "all") \(args.isTestMode ? "[TEST MODE]" : "")₊˚｡⋆❆⋆｡˚₊"
    )

    let solution: (any Solution)? = SolutionRegistry.get(day: args.day, year: args.year)

    guard let solution: any Solution = solution else {
        print("No solution found for Year \(args.year) Day \(args.day)")
        exit(1)
    }

    let input: String

    if args.isTestMode {
        input = solution.testInput
    } else {
        let client: AOCClient = AOCClient()
        do {
            input = try await client.fetchInput(for: args.year, day: args.day).trimmingCharacters(
                in: .whitespacesAndNewlines)
        } catch {
            print("Error fetching input: \(error)")
            exit(1)
        }
    }

    if #available(macOS 13.0, *) {
        switch args.part {
        case 1:
            _ = await Console.runWithAnimation(label: "Solution (1)") {
                await solution.part1(input: input)
            }
        case 2:
            _ = await Console.runWithAnimation(label: "Solution (2)") {
                await solution.part2(input: input)
            }
        default:
            print("Solution (1): ...")
            print("Solution (2): ...")
            async let result1 = Console.runWithAnimation(label: "Solution (1)", lineOffset: 2) {
                await solution.part1(input: input)
            }
            async let result2 = Console.runWithAnimation(label: "Solution (2)", lineOffset: 1) {
                await solution.part2(input: input)
            }
            _ = await (result1, result2)
        }
    }

    exit(0)
}

RunLoop.main.run()
