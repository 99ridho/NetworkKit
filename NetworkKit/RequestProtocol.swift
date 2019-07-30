import Foundation

public typealias Parameters = [String : Any]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: Parameters { get }
    var headers: [String : String] { get }
    var parameterEncoder: ParameterEncoder { get }
    var method: RequestMethod { get }
}
