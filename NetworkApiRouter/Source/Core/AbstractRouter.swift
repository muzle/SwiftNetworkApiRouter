import Foundation

public protocol AbstractRouter: URLConvertible, URLRequestConvertible {
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }

    var queryParameters: Encodable? { get }
    var body: Encodable? { get }
    var policy: URLRequest.CachePolicy { get }
    var interval: TimeInterval { get }
}

// MARK: - AbstractRouter + URLConvertible + default implementation

public extension AbstractRouter {
    func convertToURL(with encoder: JSONEncoder) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.path = path
        components.host = host
        components.port = port
        
        if let queryParameters = queryParameters {
            let items = try queryParameters.makeQuery(with: encoder)
            if !items.isEmpty {
                components.queryItems = items
            }
        }

        guard let url = components.url else { throw URLError(.badURL) }
        return url
    }
}

// MARK: - AbstractRouter + URLRequestConvertible + default implementation

public extension AbstractRouter {
    func convertToURLRequest(with encoder: JSONEncoder) throws -> URLRequest {
        let url = try convertToURL(with: encoder)
        var request = URLRequest(url: url, cachePolicy: policy, timeoutInterval: interval)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if let body = body {
            request.httpBody = try body.makeData(with: encoder)
        }

        return request
    }
}
