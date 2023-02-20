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

    public func getPhotos(count: Int = 1, offset: Int = 0, order: OrderType = .newest) async throws -> [Photo] {
        return try await search(count: count, offset: offset, order: order)
    }

    public func search(
        query: String = "",
        count: Int = 1,
        offset: Int = 0,
        merged: Bool = true,
        order: OrderType = .newest
    ) async throws -> [Photo] {

        let client = session.client

        // Start sending requests
        do {
            let request: Request<[PhotoResponse]> = Request(
                path: "/photos",
                method: .get,
                query: [
                    ("query", query),
                    ("count", String(count)),
                    ("offset", String(offset)),
                    ("merged", String(merged)),
                    ("order", order.rawValue)
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