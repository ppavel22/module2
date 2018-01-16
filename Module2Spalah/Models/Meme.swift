//
//  Meme.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//


import UIKit
import SwiftyJSON

class Meme: NSObject, NSCoding {
    
    let id: Int
    let name: String
    let height: Int
    let width: Int
    let url: URL
    
    init(id: Int, url: URL, name: String, height: Int, width: Int) {
        self.id = id
        self.url = url
        self.name = name
        self.height = height
        self.width = width
        super.init()
    }
    
    init?(json: JSON) {
        guard let url = json["url"].url else { return nil }
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = url
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(String(self.id), forKey: "id")
        aCoder.encode(self.url, forKey: "url")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(String(self.height), forKey: "height")
        aCoder.encode(String(self.width), forKey: "width")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let stringObjId = aDecoder.decodeObject(forKey: "id") as? String else { return nil }
        guard let objID = Int(stringObjId) else { return nil }
        guard let objName = aDecoder.decodeObject(forKey: "name") as? String else { return nil }
        guard let objURL = aDecoder.decodeObject(forKey: "url") as? URL else { return nil }
        guard let stringObjWidth = aDecoder.decodeObject(forKey: "width") as? String else { return nil }
        guard let objWidth = Int(stringObjWidth) else { return nil }
        guard let stringObjHeight = aDecoder.decodeObject(forKey: "height") as? String else { return nil }
        guard let objHeight = Int(stringObjHeight) else { return nil }
        self.init(id: objID, url: objURL, name: objName, height: objHeight, width: objWidth)
    }
    
}


