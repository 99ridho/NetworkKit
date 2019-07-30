import XCTest

@testable import NetworkKit

class URLParameterEncoderTest: XCTestCase {
    var encoder: URLParameterEncoder!
    
    override func setUp() {
        encoder = URLParameterEncoder.defaultInstance
    }
    
    override func tearDown() {
        encoder = nil
    }
    
    func testSetParameterToURLRequestWhenSucceded() {
        let url = URL(string: "https://google.com")!
        var urlRequest = URLRequest(url: url)
        
        let params: Parameters = [
            "q": "hello",
            "foo": "bar"
        ]
        
        try? encoder.encode(parameters: params, andAttachTo: &urlRequest)
        
        var expectedQueryItems = [URLQueryItem]()
        for (key, value) in params {
            let newValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            expectedQueryItems.append(URLQueryItem(name: key, value: newValue))
        }
        
        let actualQueryItems = URLComponents(
            url: urlRequest.url!,
            resolvingAgainstBaseURL: false
        )?.queryItems ?? []
        
        XCTAssertEqual(expectedQueryItems, actualQueryItems)
    }
}
