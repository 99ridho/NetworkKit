import Foundation

public protocol CancelableTask {
    func cancel()
}

extension URLSessionDataTask: CancelableTask { }
