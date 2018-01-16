//
//  NetworkService.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkService {
    private static var baseURL: String {
        return "https://api.imgflip.com/"
    }
    
    static func request(endpoint: Endpoint, completionHandler: ((Result<Any>) -> Void)? = nil) {
        let encoding: ParameterEncoding = (endpoint.method == .get || endpoint.method == .delete) ? URLEncoding.default : JSONEncoding.default
        Alamofire.request(baseURL + endpoint.path, method: endpoint.method, parameters: endpoint.parameters,
                          encoding: encoding).responseJSON(queue: DispatchQueue.global()) { networkResponse in
                            completionHandler?(networkResponse.result)
        }
    }
}
