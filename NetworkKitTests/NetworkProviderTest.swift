import XCTest

@testable import NetworkKit

class NetworkProviderTest: XCTestCase {
    func testNetworkProviderHitURL() {
        var actualURLRequest: URLRequest?
        
        let request = RequestMock.allContacts
        setupNetworkProvider(request: request) { (urlRequest, completionHandler) in
            actualURLRequest = urlRequest
            completionHandler?(nil, nil, nil)
        }
        
        var expectedURLRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path))
        let urlParamEncoder = URLParameterEncoder.defaultInstance
        
        try? urlParamEncoder.encode(parameters: request.parameters, andAttachTo: &expectedURLRequest)
        
        XCTAssertEqual(actualURLRequest?.url, expectedURLRequest.url)
    }
    
    func testNetworkProviderSetHeaders() {
        var actualHeaders = [String : String]()
        
        let request = RequestMock.allContacts
        setupNetworkProvider(request: request) { (urlRequest, completionHandler) in
            actualHeaders = urlRequest.allHTTPHeaderFields ?? [:]
            completionHandler?(nil, nil, nil)
        }
        
        var expectedHeaders = request.headers
        expectedHeaders["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
        
        XCTAssertEqual(actualHeaders, expectedHeaders)
    }
    
    func testNetworkProviderSetURLQuery() {
        var actualQueryComponents: [URLQueryItem]?
        
        let request = RequestMock.allContacts
        setupNetworkProvider(request: request) { (urlRequest, completionHandler) in
            guard
                let url = urlRequest.url,
                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else {
                return
            }
            
            actualQueryComponents = urlComponents.queryItems
            completionHandler?(nil, nil, nil)
        }

        XCTAssertTrue(actualQueryComponents != nil, "Query expected to be non-null because request has an parameters on it")
    }
    
    func setupNetworkProvider(request: RequestMock, fetcher: NetworkProvider<RequestMock>.Fetcher) {
        let provider = NetworkProvider<RequestMock>(fetcher: fetcher)
        provider.request(request, completion: nil)
    }
}
