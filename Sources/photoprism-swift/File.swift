import Foundation

struct FileResponse: Codable {
    var hash: String
    var fileType: String

    enum CodingKeys: String, CodingKey {
        case hash = "Hash"
        case fileType = "FileType"
    }
}

struct File {
    let session: Session
    let hash: String
    let fileType: String

    init(session: Session, response: FileResponse) {
        self.session = session
        self.hash = response.hash
        self.fileType = response.fileType
    }

    public func getThumb() async throws -> Thumb?{
        return Thumb(session: session, hash: self.hash)
    }
}