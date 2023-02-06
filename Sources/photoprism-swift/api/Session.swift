/**
 * @author petitstrawberry
 * @email petitstrawberry.dev@gmail.com
 * @create date 2023-02-06 15:15:01
 * @modify date 2023-02-06 15:15:01
 * @desc Session
 */

import Foundation

class Session {
    private var user: User
    private var url: URL
    private var id: String = ""

    private init(url: URL, user: User, id: String) {
        self.user = user
        self.url = url
        self.id = id
    }

    static func getSession(host: String, isSSL: Bool, user: User) -> Session? {
        let baseURL = isSSL ? URL(string: "https://\(host)/api/v1")! : URL(string: "http://\(host)/api/v1")!
        let reqURL = baseURL.appendingPathComponent("/session")
        var request = URLRequest(url: reqURL)
        request.httpMethod = "POST"
        let params: [String: Any] = [
            "username": user.username,
            "password": user.password
        ]

        return Session(url: baseURL, user: user, id: "test")
    }
}