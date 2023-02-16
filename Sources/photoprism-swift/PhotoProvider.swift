import Foundation
import Get

struct PhotoResponse: Codable {
    let UID: String
}

public class PhotoProvider {
    let session: Session
    let header: [String: String]

    public init(session: Session) {
        self.session = session
        self.header = [
            "X-Session-ID": self.session.id
        ]
    }

    public func getPhotos(count: Int) async throws -> [Photo] {
        return try await search(count: count)
    }

    public func search(query: String = "", count: Int) async throws -> [Photo] {
        let client = session.client

        // Start sending requests
        do {
            let request: Request<[PhotoResponse]> = Request(
                path: "/photos",
                method: .get,
                query: [
                    ("query", query),
                    ("count", String(count))
                ],
                headers: ["X-Session-ID": session.id]
            )

            let res: Response<[PhotoResponse]> = try await client.send(request)

            if res.statusCode == 200 {
                let photos: [Photo] = res.value.map {
                        Photo(session: session, id: $0.UID)
                }

                return photos
            }

            return []

        } catch let error {
            print(error)
            throw error
        }
    }
}