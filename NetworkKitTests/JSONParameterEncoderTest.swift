import XCTest

@testable import NetworkKit

class JSONParameterEncoderTest: XCTestCase {
    private var encoder: JSONParameterEncoder!
    
    override func setUp() {
        encoder = JSONParameterEncoder.defaultInstance
    }

    override func tearDown() {
        encoder = nil
    }

    func testSetParameterToURLRequestWhenSucceded() {
        let url = URL(string: "https://google.com")!
        var urlRequest = URLRequest(url: url)
        
        let parameters: Parameters = [
            "foo": "bar",
            "bar": "qux"
        ]
        
        do {
            try encoder.encode(parameters: parameters, andAttachTo: &urlRequest)
            
            let expectedData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            let actualData = urlRequest.httpBody ?? Data()
            
            XCTAssertEqual(expectedData, actualData)
        } catch {
            XCTFail("Decoding parameter error")
        }
    }
}
