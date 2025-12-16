import Foundation

Task {
    let args = Args()

    clearConsole()

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
            input = try await client.fetchInput(for: args.year, day: args.day)
        } catch {
            print("Error fetching input: \(error)")
            exit(1)
        }
    }

    switch args.part {
    case 1:
        print("Solution (1): \(solution.part1(input: input))")
    case 2:
        print("Solution (2): \(solution.part2(input: input))")
    default:
        let solutionPart1 = solution.part1(input: input)
        let solutionPart2 = solution.part2(input: input)
        print("Solution (1): \(solutionPart1)")
        print("Solution (2): \(solutionPart2)")
    }

    exit(0)
}

RunLoop.main.run()
