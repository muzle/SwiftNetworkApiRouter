import Foundation

internal extension Encodable {
    func makeQuery(with encoder: JSONEncoder) throws -> [URLQueryItem] {
        let data = try encoder.encode(self)
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NetworkApiRouterError.failedToGetJsonObject
        }
        return json.map(convertToQueryParameter(_:)).sorted(by: { $0.name.hash < $1.name.hash })
    }
    
    func makeData(with encoder: JSONEncoder) throws -> Data {
        try encoder.encode(self)
    }
    
    private func convertToQueryParameter(_ parameter: (key: String, value: Any)) -> URLQueryItem {
        let (key, value) = parameter
        if let number = value as? NSNumber, number.isBool {
            return URLQueryItem(
                name: key,
                value: String(describing: number.boolValue)
            )
        }
        return URLQueryItem(
            name: key,
            value: String(describing: value)
        )
    }
}
