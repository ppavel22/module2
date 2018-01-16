//
//  Meme.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Meme {
    
    let id: Int
    let name: String
    let height: Int
    let width: Int
    let url: URL
}

extension Meme {
    init?(json: JSON) {
        guard let url = json["url"].url else { return nil }
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = url
    }
}


