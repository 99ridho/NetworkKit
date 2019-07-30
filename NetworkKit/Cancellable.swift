import Foundation

public protocol CancellableTask {
    func cancel()
}

extension URLSessionDataTask: CancellableTask { }
