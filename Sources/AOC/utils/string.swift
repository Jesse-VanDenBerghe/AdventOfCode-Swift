extension String {
    func splitAt(index: Int) -> (String, String) {
        let splitIndex = self.index(self.startIndex, offsetBy: index)
        let firstPart = String(self[self.startIndex..<splitIndex])
        let secondPart = String(self[splitIndex..<self.endIndex])
        return (firstPart, secondPart)
    }

    func isRepeatingTwice() -> Bool {
        if self.count % 2 != 0 {
            return false
        }

        let midIndex = self.count / 2
        let (firstHalf, secondHalf) = self.splitAt(index: midIndex)

        return firstHalf == secondHalf
    }

    func isRepeatingMultipleTimes() -> Bool {
        let doubleString = self + self
        let searchStartIndex = doubleString.index(after: doubleString.startIndex)

        let foundRange = doubleString.range(
            of: self, range: searchStartIndex..<doubleString.endIndex)

        guard let foundRange else {
            return false
        }

        let indexOfFirstOccurrence = doubleString.distance(
            from: doubleString.startIndex, to: foundRange.lowerBound)

        return indexOfFirstOccurrence != self.count
    }

}
