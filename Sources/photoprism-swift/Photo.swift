import Foundation
import Get

struct DownloadPhotoResponse: Codable {
    let UID: String
}

struct Photo {
    private let session: Session
    let id: String

    init(session: Session, id: String) {
        self.session = session
        self.id = id
    }

    public func getThumb() async throws -> Thumb?{
        let files = try await getFiles()

        if files.count > 0 {
            return Thumb(session: session, hash: files[0].hash)
        }

        return nil
    }

    public func getDetails() async throws -> PhotoDetails? {
        let client = session.client

        // Start sending requests
        do {
            let request: Request<PhotoDetailsResponse> = Request(
                path: "/photos/\(id)",
                method: .get,
                headers: ["X-Session-ID": session.id]
            )

            let res: Response<PhotoDetailsResponse> = try await client.send(request)

            if res.statusCode == 200 {
                return PhotoDetails(session: session, response: res.value)
            }

            return nil

        } catch let error {
            print(error)
            throw error
        }
    }

    public func getFiles() async throws-> [File] {
        if let details = try await getDetails() {
            return details.files
        } else {
            return []
        }
    }

    public func getData() async throws -> Data? {
        let client = session.client

        // Start sending requests
        do {
            let request: Request<[DownloadPhotoResponse]> = Request(
                path: "/photos/\(id)/dl",
                method: .get,
                query: [("t", session.config.downloadToken)],
                headers: ["X-Session-ID": session.id]
            )

            let res: Response<[DownloadPhotoResponse]> = try await client.send(request)

            if res.statusCode == 200 {
                print(res.value)

                return nil
            }

            return nil

        } catch let error {
            print(error)
            throw error
        }
    }
}
