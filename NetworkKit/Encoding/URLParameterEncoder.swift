//
//  URLParameterEncoder.swift
//  Contacts
//
//  Created by Ridho Pratama on 28/07/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    static let defaultInstance = URLParameterEncoder()
    
    func encode(parameters: Parameters, andAttachTo urlRequest: inout URLRequest) throws {
        guard let url = urlRequest.url else {
            throw NetworkProviderError.missingURL
        }
        
        guard
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty
        else {
            return
        }
        
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let newValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let queryItem = URLQueryItem(name: key, value: newValue)
            
            queryItems.append(queryItem)
        }
        
        urlComponents.queryItems = queryItems
        urlRequest.url = urlComponents.url
        
        urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}
