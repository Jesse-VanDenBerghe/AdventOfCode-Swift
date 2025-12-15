import Foundation

Task {
    let args = Args()

    print("Running Year \(args.year) Day \(args.day) Part \(args.part) \(args.isTestMode ? "[TEST MODE]" : "")")

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

    args.part == 1 ?
        print("Solution (1): \(solution.part1(input: input))") :
        print("Solution (2): \(solution.part2(input: input))")

    exit(0)
}

RunLoop.main.run()
