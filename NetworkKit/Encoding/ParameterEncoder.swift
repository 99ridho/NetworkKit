//
//  ParameterEncoding.swift
//  Contacts
//
//  Created by Ridho Pratama on 27/07/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
    func encode(parameters: Parameters, andAttachTo urlRequest: inout URLRequest) throws
}
