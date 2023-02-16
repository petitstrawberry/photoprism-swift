/**
 * @author petitstrawberry
 * @email petitstrawberry.dev@gmail.com
 * @create date 2023-02-06 15:09:01
 * @modify date 2023-02-06 15:12:05
 * @desc User
 */

public struct User: Codable {
    let username: String
    let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}