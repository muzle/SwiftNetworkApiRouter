## ApiRouter

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/muzle/SwiftNetworkApiRouter/blob/master/LICENSE)
[![codebeat badge](https://codebeat.co/badges/6c346142-a942-4c13-ae6b-5517b4c50b1d)](https://codebeat.co/projects/github-com-muzle-swiftnetworkapirouter-master)

Library to simplify network routing management

## Usage

```swift
import Foundation
import ApiRouter

internal enum WordRouter {
    case words(query: Encodable)
    case wordMeaning(query: Encodable)
}

// MARK: - Implement AbstractRouter

extension WordRouter: AbstractRouter {
    var path: String {
        switch self {
        case .words:
            return publicV1 + "/words/search"
        case .wordMeaning:
            return publicV1 + "/meanings"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryParameters: Encodable? {
        switch self {
        case .wordMeaning(let query), .words(let query):
            return query
        }
    }
    
    var body: Encodable? {
        nil
    }
}
```

```swift
let request = try route.convertToURLRequest(with: JSONEncoder())
let url = try route.convertToURL(with: JSONEncoder())
```
## Instalation
### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'ApiRouter'
end
```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```

## Authors
Eugene Rudakov - [linkedin](https://www.linkedin.com/in/voragomod/)