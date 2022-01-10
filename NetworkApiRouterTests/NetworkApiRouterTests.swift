import XCTest
@testable import NetworkApiRouter

class NetworkApiRouterTests: XCTestCase {
    private let scheme: String = "https"
    private let host: String = "muzle.com"
    private let port: Int = 5001
    private let path1: String = ""
    private let path2: String = "/test"
    private let method: HTTPMethod = .get
    private let headers: HTTPHeaders = ["header": "parameter"]
    private let policy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private let interval: TimeInterval = 60
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom({ [dateFormatter] date, encoder in
            let dateText = dateFormatter.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(dateText)
        })
        return encoder
    }()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testURL() throws {
        let query = Query.stub(string: "Test string")
        let route = makeRoute(path: path1, method: .get, queryParameters: query)
        let url = try route.convertToURL(with: encoder)
        let dateStr = dateFormatter.string(from: query.date)
        let resultURL = "\(scheme)://\(host):\(port)?int=\(query.int)&bool=\(query.bool)&date=\(dateStr)&string=Test%20string&decimal=\(query.decimal)"
        XCTAssertEqual(url.absoluteString, resultURL)
    }
    
    func testURLRequest() throws {
        let query = Query.stub(string: "Test string")
        let route = makeRoute(path: path1, method: .get, queryParameters: query, body: query)
        let data = try encoder.encode(query)
        let urlRequest = try route.convertToURLRequest(with: encoder)
        let dateStr = dateFormatter.string(from: query.date)
        let resultURL = "\(scheme)://\(host):\(port)?int=\(query.int)&bool=\(query.bool)&date=\(dateStr)&string=Test%20string&decimal=\(query.decimal)"
        XCTAssertEqual(urlRequest.url?.absoluteString, resultURL)
        XCTAssertEqual(urlRequest.httpMethod, method.rawValue)
        XCTAssertEqual(urlRequest.timeoutInterval, interval)
        XCTAssertEqual(urlRequest.cachePolicy, policy)
        XCTAssertEqual(urlRequest.httpBody, data)
    }
    
    func makeRoute(
        path: String,
        method: HTTPMethod = .get,
        queryParameters: Encodable? = nil,
        body: Encodable? = nil
    ) -> AbstractRouter {
        RouterMock.stub(
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
    
    struct Query: Encodable {
        let bool: Bool
        let date: Date
        let string: String
        let decimal: Decimal
        let int: Int
        
        static func stub(
            bool: Bool = true,
            date: Date = Date(),
            string: String = "String",
            decimal: Decimal = 10.78,
            int: Int = 104
        ) -> Self {
            Self(
                bool: bool,
                date: date,
                string: string,
                decimal: decimal,
                int: int
            )
        }
    }
}
