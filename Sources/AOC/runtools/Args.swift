public struct Args {
    public var day: Int = 1
    public var part: Int? = nil
    public var year: Int = 2025
    public var isTestMode: Bool = true

    public init() {
        var args: ArraySlice<String> = CommandLine.arguments.dropFirst()

        while args.count >= 2 {
            let labelIndex = args.startIndex
            let valueIndex = args.index(after: labelIndex)
            let argLabel = args[labelIndex]
            let argValue = args[valueIndex]

            switch argLabel {
            case "--day":
                self.day = Int(argValue) ?? 1
            case "--part":
                self.part = Int(argValue)
            case "--year":
                self.year = Int(argValue) ?? 2025
            case "--test":
                self.isTestMode = Bool(argValue) ?? false
            default:
                break
            }

            args = args.dropFirst(2)
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}