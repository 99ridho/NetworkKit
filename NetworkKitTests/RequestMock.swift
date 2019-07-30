import Foundation

@testable import NetworkKit

enum RequestMock {
    case allContacts
}

extension RequestMock: RequestProtocol {
    var baseURL: URL {
        return URL(string: "https://google.com")!
    }
    
    var path: String {
        switch self {
        case .allContacts:
            return "/foo"
        }
    }
    
    var parameters: Parameters {
        return [
            "foo" : "bar",
            "qux" : "le"
        ]
    }
    
    var headers: [String : String] {
        return [
            "X-Header" : "Foo"
        ]
    }
    
    var parameterEncoder: ParameterEncoder {
        return URLParameterEncoder.defaultInstance
    }
    
    var method: RequestMethod {
        return .get
    }
}
