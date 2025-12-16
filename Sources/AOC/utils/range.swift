struct Range{
    let from: Int
    let to: Int
}

struct StringRange{
    let from: String
    let to: String

    func toRange() -> Range {
        Range(from: Int(from)!, to: Int(to)!)
    }

    func forEachItemInRange(_ body: (String) -> Void) {
        let range = toRange()
        for i in range.from...range.to {
            body(String(i))
        }
    }
}

extension [StringRange] {
    func forEachItemInRanges(_ body: (String) -> Void) {
        self.forEach { range in
            range.forEachItemInRange { item in
                body(item)
            }
        }
    }
}