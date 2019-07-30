import Foundation

public class NetworkProvider<Request: RequestProtocol> {
    public typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    public typealias Fetcher = (URLRequest, CompletionHandler?) -> CancelableTask
    
    private var fetcher: Fetcher
    
    public init(
        fetcher: @escaping Fetcher = { (urlRequest, completion) -> CancelableTask in
            let task = URLSession.shared.dataTask(
                with: urlRequest,
                completionHandler: { (data, urlResponse, error) in
                    completion?(data, urlResponse, error)
                }
            )
        
            task.resume()
        
            return task
        }
    ) {
        self.fetcher = fetcher
    }
    
    @discardableResult
    public func request (_ request: Request, completion: CompletionHandler?) -> CancelableTask? {
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
            return nil
        }
        
        return fetcher(urlRequest, completion)
    }
}
