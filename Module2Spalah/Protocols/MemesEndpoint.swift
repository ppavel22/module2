//
//  MemesEndpoint.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Alamofire

enum MemesEndpoint: Endpoint {
    case memes
}

// MARK: - Endpoint
extension MemesEndpoint {
    var method: HTTPMethod {
        return .get
    }
    var parameters: [String: Any]? {
        return nil
    }
    var path: String {
        return "get_memes"
    }
}
