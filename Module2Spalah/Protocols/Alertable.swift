//
//  Alertable.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

protocol Alertable {
    func showAlert(title: String?, message: String?, handler: (() -> Void)?)
}

extension Alertable where Self: UIViewController {
    
    func showAlert(title: String?, message: String? = nil, handler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ in handler?() })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
