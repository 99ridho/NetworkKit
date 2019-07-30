import XCTest

@testable import NetworkKit

class NetworkProviderTest: XCTestCase {
    func testNetworkProviderHitURL() {
        var actualURLRequest: URLRequest?
        
        let request = RequestMock.allContacts
        let provider = NetworkProvider<RequestMock> { (urlRequest, completionHandler) in
            actualURLRequest = urlRequest
            completionHandler?(nil, nil, nil)
            return MockDataTask()
        }
        
        provider.request(request, completion: nil)
        
        var expectedURLRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path))
        let urlParamEncoder = URLParameterEncoder.defaultInstance
        
        try? urlParamEncoder.encode(parameters: request.parameters, andAttachTo: &expectedURLRequest)
        
        XCTAssertEqual(actualURLRequest?.url, expectedURLRequest.url)
    }
    
    func testNetworkProviderSetHeaders() {
        var actualHeaders = [String : String]()
        
        let request = RequestMock.allContacts
        let provider = NetworkProvider<RequestMock> { (urlRequest, completionHandler) in
            actualHeaders = urlRequest.allHTTPHeaderFields ?? [:]
            completionHandler?(nil, nil, nil)
            return MockDataTask()
        }
        
        provider.request(request, completion: nil)
        
        var expectedHeaders = request.headers
        expectedHeaders["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
        
        XCTAssertEqual(actualHeaders, expectedHeaders)
    }
    
    func testNetworkProviderSetURLQuery() {
        var actualQueryComponents: [URLQueryItem]?
        
        let request = RequestMock.allContacts
        let provider = NetworkProvider<RequestMock> { (urlRequest, completionHandler) in
            guard
                let url = urlRequest.url,
                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else {
                return MockDataTask()
            }
            
            actualQueryComponents = urlComponents.queryItems
            completionHandler?(nil, nil, nil)
            return MockDataTask()
        }
        
        provider.request(request, completion: nil)

        XCTAssertTrue(actualQueryComponents != nil, "Query expected to be non-null because request has an parameters on it")
    }
    
    func testCancelTask() {
        let request = RequestMock.allContacts
        let provider = NetworkProvider<RequestMock> { (urlRequest, completionHandler) in
            completionHandler?(nil, nil, nil)
            return MockDataTask()
        }
        
        let cancellable = provider.request(request, completion: nil) as? MockDataTask
        
        cancellable?.cancel()
        
        XCTAssertTrue(cancellable?.cancelInvoked ?? false, "Cancel function doesn't called")
    }
}

class MockDataTask: CancelableTask {
    var cancelInvoked: Bool = false
    
    func cancel() {
        cancelInvoked = true
    }
}
