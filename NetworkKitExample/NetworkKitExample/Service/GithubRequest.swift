//
//  GithubRequest.swift
//  NetworkKitExample
//
//  Created by Ridho Pratama on 01/08/19.
//  Copyright © 2019 Ridho Pratama. All rights reserved.
//

import Foundation
import NetworkKit

enum GithubRequest {
    case fetchUser(username: String)
}

extension GithubRequest: RequestProtocol {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case let .fetchUser(username):
            return "/users/\(username)"
        }
    }
    
    var parameters: Parameters {
        return [:]
    }
    
    var headers: [String : String] {
        return [
            "Accept" : "application/vnd.github.v3+json"
        ]
    }
    
    var parameterEncoder: ParameterEncoder {
        return URLParameterEncoder.defaultInstance
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchUser:
            return .get
        }
    }
}
