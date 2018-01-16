//
//  DetailsViewController.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var ibImage: UIImageView!
    @IBOutlet private weak var ibLabel: UILabel!
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        guard let favoriteMeme = meme else { return }
         ibImage.af_setImage(withURL: favoriteMeme.url, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        ibLabel.text = favoriteMeme.name
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        guard let meme = meme else { return }
        DataManager.instance.deleteMeme(meme: meme)
        navigationController?.popViewController(animated: true)
    }
    
}

