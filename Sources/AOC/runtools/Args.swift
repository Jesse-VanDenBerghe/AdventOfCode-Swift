public struct Args {
    public let day: Int
    public let part: Int
    public let year: Int
    public let isTestMode: Bool

    public init() {
        let args: Array<String>.SubSequence = CommandLine.arguments.dropFirst()
        
        self.year = Int(args[safe: 1] ?? "2024")!
        self.day = Int(args[safe: 2] ?? "1")!
        self.part =  Int(args[safe: 3] ?? "1")!
        self.isTestMode = Bool(args[safe: 4] ?? "false")!
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}