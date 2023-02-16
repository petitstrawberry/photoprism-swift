import Foundation
import Get

public enum ThumbSize: String {
    case tile50 = "tile_50"
    case tile100 = "tile_100"
    case tile224 = "tile_224"
    case tile500 = "tile_500"
    case colors = "colors"
    case left224 = "left_224"
    case right224 = "right_224"
    case fit720 = "fit_720"
    case fit1280 = "fit_1280"
    case fit1920 = "fit_1920"
    case fit2048 = "fit_2048"
    case fit2560 = "fit_2560"
    case fit3840 = "fit_3840"
    case fit4096 = "fit_4096"
    case fit7680 = "fit_7680"
}

public struct Thumb {
    private let session: Session
    let hash: String

    init(session: Session, hash: String) {
        self.session = session
        self.hash = hash
    }

    public func getThumbPathString(size: ThumbSize) -> String {

        return "/t/\(hash)/\(session.config.previewToken)/\(size.rawValue)"
    }

    public func getData(size: ThumbSize) async throws -> Data? {
        let client = session.client
        let path = getThumbPathString(size: size)

        print(path)

        do {
            let request: Request<Data> = Request(
                path: path,
                method: .get,
                headers: ["X-Session-ID": session.id]
            )

            let res: Response<Data> = try await client.send(request)

            if res.statusCode == 200 {
                return res.value
            }

            return nil

        } catch let error {
            print(error)
            throw error
        }
    }
}