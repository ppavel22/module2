//
//  Endpoint.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Alamofire

protocol Endpoint {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
}
