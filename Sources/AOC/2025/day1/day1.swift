import Foundation

struct AOC_1_2025: Solution {
    var day: Int { 1 }
    var year: Int { 2025 }

    func part1(input: String) -> String {
        let lines = input.components(separatedBy: "\n")

        let dail = Dail()
        var endedAtZero = 0

        for line in lines {
            let _ = dail.rotate(rotation: line)
            print(dail.at)
            if dail.at == 0 {
                endedAtZero += 1
            }
        }
        return endedAtZero.formatted()
    }

    func part2(input: String) -> String {
        let lines = input.components(separatedBy: "\n")

        let dail = Dail()
        var endedAtZero = 0

        for line in lines {
            let result = dail.rotate(rotation: line)
            if dail.at == 0 {
                endedAtZero += 1
            }
            endedAtZero += result.passedZero
        }
        return endedAtZero.formatted()
    }
}

class Dail {
    static let MAX_AT = 100

    var at: Int = 50

    func rotate(rotation: String) -> (newNumber: Int, passedZero: Int) {
        let (directionString, amount) = (String(rotation.first ?? "L"), Int(rotation.dropFirst()) ?? 0)

        let direction = Direction(rawValue: directionString) ?? .L
        let startNumber = at
        let rotationAmount = at + direction.multiplier * amount

        let wrapped = ((rotationAmount % Dail.MAX_AT) + Dail.MAX_AT) % Dail.MAX_AT
        at = wrapped

        var passedZero = abs(Int(floor(Double(rotationAmount) / Double(Dail.MAX_AT))))

        if direction == .L && startNumber == 0 {
            passedZero -= 1
        }
        if direction == .R && at == 0 {
            passedZero -= 1
        }

        return (newNumber: at, passedZero: passedZero)
    }
}

enum Direction: String {
    case L
    case R

    var multiplier: Int {
        switch self {
        case .L:
            return -1
        case .R:
            return 1
        }
    }
}