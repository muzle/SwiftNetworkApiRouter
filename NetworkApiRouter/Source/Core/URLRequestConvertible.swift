import Foundation

public protocol URLRequestConvertible {
    func convertToURLRequest(with encoder: JSONEncoder) throws -> URLRequest
}
