//
//  FavoriteMemeViewController.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class FavoriteMemeViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        collectionView?.register(MemeCollectionCell.nib, forCellWithReuseIdentifier: MemeCollectionCell.reuseID)
        guard let emailToLoad = DataManager.instance.email else { return }
        DataManager.instance.loadFavoriteMemes(for: emailToLoad)
        addObservers()
    }
    
    // Private methods
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(memeAdded), name: .MemeAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(memeDeleted), name: .MemeDeleted, object: nil)
    }
    
    private func newRootViewController(with identifier: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        let navigationController = UINavigationController(rootViewController: nextViewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = navigationController
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        DataManager.instance.logout()
        newRootViewController(with: "LoginController")
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? DetailsViewController else { return }
        destVC.meme = sender as? Meme
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension FavoriteMemeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.instance.favoriteMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionCell.reuseID, for: indexPath) as? MemeCollectionCell
            else {
                fatalError("Cell does not exist")
        }
        let meme = DataManager.instance.favoriteMemes[indexPath.item]
        let memeName = meme.name
        let memeUrl = meme.url
        cell.update(memeName: memeName, memeUrl: memeUrl)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = DataManager.instance.favoriteMemes[indexPath.item]
        performSegue(withIdentifier: "Details", sender: meme)
    }
}

// MARK: UICollectionViewLayout
extension FavoriteMemeViewController: UICollectionViewDelegateFlowLayout {
    
    private var minItemSpace: CGFloat { return 12 }
    private var itemsPerRow: CGFloat { return 2 }
    private var sectionInsets: UIEdgeInsets { return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = minItemSpace * (itemsPerRow - 1) + sectionInsets.left + sectionInsets.right
        let availableW = collectionView.bounds.width - padding
        let widthPerItem = availableW / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
}

// MARK: - Notifications

private extension FavoriteMemeViewController {
    
    @objc func memeAdded() {
        collectionView?.reloadData()
    }
    
    @objc func memeDeleted() {
        collectionView?.reloadData()
    }
}
