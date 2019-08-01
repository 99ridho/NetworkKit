//
//  GithubService.swift
//  NetworkKitExample
//
//  Created by Ridho Pratama on 01/08/19.
//  Copyright © 2019 Ridho Pratama. All rights reserved.
//

import Foundation
import NetworkKit

protocol GithubService {
    func fetchUser(byUsername username: String, completion: ((Result<GithubUserResponse, Error>) -> Void)?)
}

class DefaultGithubService: GithubService {
    private let networkProvider: NetworkProvider<GithubRequest>
    private let jsonDecoder: JSONDecoder
    
    init(provider: NetworkProvider<GithubRequest> = NetworkProvider<GithubRequest>()) {
        self.networkProvider = provider
        self.jsonDecoder = JSONDecoder()
        
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchUser(byUsername username: String, completion: ((Result<GithubUserResponse, Error>) -> Void)?) {
        networkProvider.request(.fetchUser(username: username)) { [jsonDecoder] (data, urlResponse, error) in
            guard let theData = data else {
                completion?(.failure(NetworkProviderError.missingData))
                return
            }
            
            do {
                let user = try jsonDecoder.decode(GithubUserResponse.self, from: theData)
                completion?(.success(user))
            } catch (let error) {
                completion?(.failure(error))
            }
        }
    }
}
