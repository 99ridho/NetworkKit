import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    static let defaultInstance = JSONParameterEncoder()
    
    func encode(parameters: Parameters, andAttachTo urlRequest: inout URLRequest) throws {
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = data
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch (let error) {
            throw NetworkProviderError.encodingError(error)
        }
    }
}
