//
//  Extensions.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import PKHUD

extension Notification.Name {
    
    static let MemesLoaded = Notification.Name("MemesLoaded")
    static let FailedLoadMemes = Notification.Name("FailedLoadMemes")
    static let MemeAdded = Notification.Name("MemeAdded")
    static let MemeDeleted = Notification.Name("MemeDeleted")
    
}

extension HUD {
    static func showProgress(hideTimeout: TimeInterval = 10) {
        self.show(.progress)
        self.hide(afterDelay: hideTimeout)
    }
}

extension String {
    
    var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
