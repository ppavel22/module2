//
//  MemeCollectionCell.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage



class MemeCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var ibImage: UIImageView!
    @IBOutlet private weak var ibLabel: UILabel!
    static let reuseID = String(describing: MemeCollectionCell.self)
    static let nib = UINib(nibName: String(describing: MemeCollectionCell.self), bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(memeName: String, memeUrl: URL) {
        ibImage.image = #imageLiteral(resourceName: "placeholder")
        ibLabel.text = memeName
        self.ibImage.af_setImage(withURL: memeUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
