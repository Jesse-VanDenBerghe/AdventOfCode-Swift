import Foundation

struct Console {

    static func clearConsole() {
        print("\u{001B}[2J\u{001B}[3J\u{001B}[H", terminator: "")
        fflush(stdout)
    }

    static func moveCursorToStart() {
        print("\u{001B}[H", terminator: "")
        fflush(stdout)
    }

    static func moveCursorToLine(_ line: Int) {
        print("\u{001B}[\(line);0H", terminator: "")
        fflush(stdout)
    }

    static func clearLine() {
        print("\u{001B}[2K", terminator: "")
        fflush(stdout)
    }

    static func printOnSameLine(_ text: String) {
        print("\r\u{001B}[2K\(text)", terminator: "")
        fflush(stdout)
    }

    static func printAndFinishLine(_ text: String) {
        print("\r\u{001B}[2K\(text)")
        fflush(stdout)
    }

    static func printOnLineWithOffset(_ text: String, offset: Int, finishLine: Bool = false) {
        if offset == 0 {
            printOnSameLine(text)
            return
        }

        print("\u{001B}[\(offset)A\r\u{001B}[2K\(text)", terminator: finishLine ? "\n" : "")
        print("\u{001B}[\(offset - (finishLine ? 1 : 0))B", terminator: "")
        fflush(stdout)
    }

    @available(macOS 13.0, *)
    static func runWithAnimation<T>(
        label: String,
        lineOffset: Int = 0,
        task: @escaping @Sendable () async -> T
    ) async -> T {
        let frames = [".", "..", "..."]
        var frameIndex = 0
        
        let animationTask = Task {
            while !Task.isCancelled {
                if lineOffset > 0 {
                    printOnLineWithOffset("\(label): \(frames[frameIndex])", offset: lineOffset)
                } else {
                    printOnSameLine("\(label): \(frames[frameIndex])")
                }
                frameIndex = (frameIndex + 1) % frames.count
                try? await Task.sleep(for: .milliseconds(300))
            }
        }
        
        let result = await task()
        animationTask.cancel()
        
        try? await Task.sleep(for: .milliseconds(50))
        
        if lineOffset > 0 {
            printOnLineWithOffset("\(label): \(result)", offset: lineOffset, finishLine: true)
        } else {
            printAndFinishLine("\(label): \(result)")
        }
        
        return result
    }
}
