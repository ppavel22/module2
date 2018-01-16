//
//  AllMemesViewController.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import PKHUD

class AllMemesViewController: UICollectionViewController, Alertable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Memes"
        addObservers()
        loadMemes()
        
        collectionView?.register(MemeCollectionCell.nib, forCellWithReuseIdentifier: MemeCollectionCell.reuseID)
    }
    
    // MARK: - Private methods
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(memesLoaded), name: .MemesLoaded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(failLoadMemes), name: .FailedLoadMemes, object: nil)
    }
    
    private func loadMemes() {
        HUD.showProgress()
        DataManager.instance.loadMemes()
    }
}
// MARK: UICollectionViewDataSource

extension AllMemesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.instance.allMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionCell.reuseID, for: indexPath) as? MemeCollectionCell
            else {
                fatalError("Cell does not exist")
        }
        
        let meme = DataManager.instance.allMemes[indexPath.item]
        let memeName = meme.name
        let memeUrl = meme.url
        cell.update(memeName: memeName, memeUrl: memeUrl)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = DataManager.instance.allMemes[indexPath.item]
        DataManager.instance.saveFavoriteMemes(meme: meme)
        navigationController?.popViewController(animated: true)
    }
    
}
// MARK: UICollectionViewLayout
extension AllMemesViewController: UICollectionViewDelegateFlowLayout {
    private var minItemSpace: CGFloat { return 12 }
    private var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
    }
    private var itemsPerRow: CGFloat { return 2 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = minItemSpace * (itemsPerRow - 1) + sectionInsets.left + sectionInsets.right
        let availableW = collectionView.bounds.width - padding
        let widthPerItem = availableW / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpace
    }
    
   
    
}

// MARK: - Notifications

private extension AllMemesViewController {
    
    @objc func memesLoaded() {
        HUD.hide()
        collectionView?.reloadData()
    }
    
    @objc func failLoadMemes() {
        HUD.hide()
        showAlert(title: "Loading failed")
    }
}
