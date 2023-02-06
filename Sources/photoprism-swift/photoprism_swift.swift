public struct photoprism_swift {
    public private(set) var text = "Hello, World!"

    public init() {
        print("Hello")

        let session = Session.getSession(host: "192.168.0.38:20800", isSSL: false, user: User(username: "admin", password: "photo-mariko-broken"))
    }
}
