import Foundation

struct AOCClient {
    
    let baseURL: String = "https://adventofcode.com"

    func sessionCookie() -> String? {
        return ProcessInfo.processInfo.environment["AOC_SESSION_COOKIE"]
    }

    func fetchInput(for year: Int, day: Int) async throws -> String {
        let getRequestURL = URL(string: "\(baseURL)/\(year)/day/\(day)/input")!
        var request = URLRequest(url: getRequestURL)
        if let sessionCookie = sessionCookie() {
            request.addValue("session=\(sessionCookie)", forHTTPHeaderField: "Cookie")
        }

        let (data, response) = try await URLSession.shared.data(for: request)   
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return String(decoding: data, as: UTF8.self)
    }
}