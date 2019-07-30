# NetworkKit

I'm trying to do some an experiment to make a simple URLSession & URLSessionTask abstraction that intended to make a HTTP call so easy than before. Inspired by [Moya](https://github.com/Moya/Moya)

## Usage

Just define the your request type that conforms to `RequestProtocol`

```swift
enum ProfileRequest {
    case profileByID(id: Int)
}

extension ProfileRequest: RequestProtocol {
    var baseURL: URL { 
        return URL(string: "http://yourapi.com")
    }

    var path: String {
        switch self {
        case .profileByID:
            return "/profile"
        }
    }

    var parameters: Parameters { 
        switch self {
        case .profileByID(let id):
            return ["id" : id]
        }
    }

    var headers: [String : String] { 
        return [:]
    }

    var parameterEncoder: ParameterEncoder { 
        switch self {
        case .profileByID:
            return URLParameterEncoder.defaultInstance
        }
    }

    var method: RequestMethod { 
        switch self {
        case .profileByID:
            return .get
        }
    }
}
```

Then make the provider & do some request!

```swift
let provider = NetworkProvider<ProfileRequest>.makeDefaultProvider()

provider.request(.profileByID(id: 1)) { result in 
    // handle your result
}
```

## Installation

Currently manual yet, just add this project to your workspace & don't forget to link the `NetworkKit.framework` at your app build phase.