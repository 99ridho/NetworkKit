//
//  NetworkProviderError.swift
//  Contacts
//
//  Created by Ridho Pratama on 27/07/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import Foundation

enum NetworkProviderError: Error {
    case encodingError(Error)
    case mappingError(Error)
    case networkError(HTTPURLResponse?)
    case missingData
    case missingURL
}
