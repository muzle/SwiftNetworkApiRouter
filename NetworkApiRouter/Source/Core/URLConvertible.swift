import Foundation

public protocol URLConvertible {
    func convertToURL(with encoder: JSONEncoder) throws -> URL
}
