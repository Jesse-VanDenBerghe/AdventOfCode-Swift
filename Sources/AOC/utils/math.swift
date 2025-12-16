extension Int {
    func mod(_ modulus: Int) -> Int {
        return ((self % modulus) + modulus) % modulus
    }
}