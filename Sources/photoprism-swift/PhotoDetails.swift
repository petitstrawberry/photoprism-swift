import Foundation

struct PhotoDetailsResponse: Codable {
    var uid: String
    var files: [FileResponse]
    var type: String

    enum CodingKeys: String, CodingKey {
        case uid = "UID"
        case files = "Files"
        case type = "Type"
    }
}

public struct PhotoDetails {
    private let session: Session
    public let uid: String
    public let files: [File]
    public let type: String

    init(session: Session, response: PhotoDetailsResponse) {
        self.session = session
        self.uid = response.uid
        self.files = response.files.map {res in
            File(session: session, response: res)
        }
        self.type = response.type
    }
}