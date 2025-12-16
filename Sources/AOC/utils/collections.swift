extension Sequence where Element: Numeric {
    func sum() -> Element {
        reduce(.zero, +)
    }

    func product() -> Element {
        reduce(1, *)
    }

    func concat() -> String {
        self.map { "\($0)" }.joined()
    }
}