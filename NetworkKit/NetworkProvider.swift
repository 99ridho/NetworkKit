import Foundation

class NetworkProvider<Request: RequestProtocol> {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    typealias Fetcher = ((URLRequest, NetworkProvider.CompletionHandler?) -> Void)?
    
    private var fetcher: Fetcher
    
    init(fetcher: Fetcher) {
        self.fetcher = fetcher
    }
    
    func request (_ request: Request, completion: NetworkProvider.CompletionHandler?) {
        let url = request.baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        for headerPair in request.headers {
            let (key, value) = headerPair
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        do {
            try request.parameterEncoder.encode(parameters: request.parameters, andAttachTo: &urlRequest)
        } catch (let error) {
            completion?(nil, nil, error)
        }
        
        fetcher?(urlRequest, completion)
    }
    
    static func makeDefaultProvider() -> NetworkProvider<Request> {
        let fetcher: NetworkProvider.Fetcher = { (urlRequest, completion) in
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
                completion?(data, urlResponse, error)
            })
            
            task.resume()
        }
        
        return NetworkProvider<Request>(fetcher: fetcher)
    }
}

