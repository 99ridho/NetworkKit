import Foundation

enum NetworkProviderError: Error {
    case encodingError(Error)
    case mappingError(Error)
    case networkError(HTTPURLResponse?)
    case missingData
    case missingURL
}
