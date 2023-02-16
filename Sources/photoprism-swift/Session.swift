import Foundation
import Get

struct SessionResponse: Codable {
    var config: Config
    var id: String
}

struct Config: Codable {
    var previewToken: String
    var downloadToken: String
}

public class Session {
    let id: String
    let baseURL: URL
    // let user: User
    let client: PhotoPrismAPIClient
    let config: Config

    private init(id: String, baseURL: URL, client: PhotoPrismAPIClient, config: Config) {
        self.baseURL = baseURL
        self.id = id
        // self.user = user
        self.client = client
        self.config = config
    }

    static func createSession(host: String, isSSL: Bool, user: User) async throws -> Session? {
        let baseURL = URL(string: isSSL ? "https://\(host)/api/v1" : "http://\(host)/api/v1")

        let client = PhotoPrismAPIClient(baseURL: baseURL)

        // Start sending requests
        do {
            let request: Request<SessionResponse> = Request(path: "/session", method: .post, body: user)

            let res = try await client.send(request)

            if res.statusCode == 200 {
                let id = res.value.id
                let config = res.value.config
                return Session(id: id, baseURL: baseURL!, client: client, config: config)
            }
            return nil

        } catch let error {
            print(error)
            throw error
        }
    }
}
