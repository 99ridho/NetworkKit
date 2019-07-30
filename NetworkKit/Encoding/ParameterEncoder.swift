import Foundation

public protocol ParameterEncoder {
    func encode(parameters: Parameters, andAttachTo urlRequest: inout URLRequest) throws
}
