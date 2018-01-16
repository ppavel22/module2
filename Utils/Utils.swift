//
//  Utils.swift
//  Module2Spalah
//
//  Created by mac on 16.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

struct Utils {
    static var documentsUrl: URL {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {fatalError("Strangeee")}
        return path
    }
    static let fileName = "ArrayOfMemes"
    static func pathInDocument(with user: String) -> URL {
        var pathToSend = documentsUrl
        pathToSend.appendPathComponent(user)
        return pathToSend
    }
}
