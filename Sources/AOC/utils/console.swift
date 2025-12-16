import Foundation

func clearConsole() {
    print("\u{001B}[2J\u{001B}[3J\u{001B}[H", terminator: "")
    fflush(stdout)
}