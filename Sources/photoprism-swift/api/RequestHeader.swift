import Foundation

struct RequestHeader: Codable {
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case sessionID = "X-Session-ID"
    }
}
