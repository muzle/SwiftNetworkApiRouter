import Foundation
import NetworkApiRouter

struct RouterMock: AbstractRouter {
    var scheme: String
    var host: String
    var port: Int?
    var path: String
    var method: HTTPMethod
    var headers: HTTPHeaders
    var queryParameters: Encodable?
    var body: Encodable?
    var policy: URLRequest.CachePolicy
    var interval: TimeInterval
    
    static func stub(
        scheme: String = "https",
        host: String = "muzle.com",
        port: Int? = nil,
        path: String = "",
        method: HTTPMethod = .get,
        headers: HTTPHeaders = [:],
        queryParameters: Encodable? = nil,
        body: Encodable? = nil,
        policy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        interval: TimeInterval = 60
    ) -> Self {
        Self(
            scheme: scheme,
            host: host,
            port: port,
            path: path,
            method: method,
            headers: headers,
            queryParameters: queryParameters,
            body: body,
            policy: policy,
            interval: interval
        )
    }
}
