//
//  DataManager.swift
//  Module2Spalah
//
//  Created by mac on 15.01.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import SwiftyJSON
import Alamofire
import KeychainSwift


final class DataManager {
    static let instance = DataManager()
    private init() {
        email = keychain.get("email")
    }
    private(set) var allMemes: [Meme] = []
    private(set) var favoriteMemes: [Meme] = []
    private(set) var email: String?
    
    let keychain = KeychainSwift()
    
    // MARK: - Private methods
    
    private func  postNotificationInMain(withName name: Notification.Name, userInfo: [AnyHashable: Any]? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
        }
    }
    
    private func getIndex(of meme: Meme, in memesArray: [Meme]) -> Int? {
        var memeIndex: Int?
        for (index, item) in memesArray.enumerated() {
            if item.id == meme.id {
                memeIndex = index
                break
            }
        }
        return  memeIndex
    }
    
    // MARK: - Network actions
    
    func loadMemes() {
        NetworkService.request(endpoint: MemesEndpoint.memes) { [unowned self] response in
            guard let value = response.value else { self.postNotificationInMain(withName: .FailedLoadMemes)
                return }
            let json = JSON(value)
            guard let jsonArray = json["data"]["memes"].array else { fatalError(" JSON Error" ) }
            self.allMemes = []
            for item in jsonArray {
                guard let meme = Meme(json: item) else { continue }
                self.allMemes.append(meme)
            }
            self.postNotificationInMain(withName: .MemesLoaded)
        }
    }
    
    // MARK: - Storage actions
    
    func addMeme(meme: Meme) {
        favoriteMemes.append(meme)
        NotificationCenter.default.post(name: .MemeAdded, object: nil)
    }
    
    func saveFavoriteMemes(meme: Meme) {
        guard let email = email else { return }
        favoriteMemes.append(meme)
        var documentsUrl = Utils.pathInDocument(with: email)
        if !FileManager.default.fileExists(atPath: documentsUrl.path) {
            do {
                try FileManager.default.createDirectory(at: documentsUrl, withIntermediateDirectories: true)
                print("Directory \(documentsUrl.path) was created")
            } catch {
                print("Directory was not created")
            }
        }
        documentsUrl.appendPathComponent(Utils.fileName)
        NSKeyedArchiver.archiveRootObject(self.favoriteMemes, toFile: documentsUrl.path)
        NotificationCenter.default.post(name: .MemeAdded, object: nil)
    }
    
    func loadFavoriteMemes() {
        guard let email = email else { return }
        var pathToLoad = Utils.pathInDocument(with: email)
        pathToLoad.appendPathComponent(Utils.fileName)
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: pathToLoad.path) as? [Meme] {
            self.favoriteMemes = data
        }
    }
    
    func deleteMeme(meme: Meme) {
        guard !favoriteMemes.isEmpty else { return }
        guard let index = getIndex(of: meme, in: favoriteMemes) else { return }
        favoriteMemes.remove(at: index)
        guard let email = email else { return }
        var documentsUrl = Utils.pathInDocument(with: email)
        documentsUrl.appendPathComponent(Utils.fileName)
        NSKeyedArchiver.archiveRootObject(self.favoriteMemes, toFile: documentsUrl.path)
        NotificationCenter.default.post(name: .MemeDeleted, object: nil)
    }
    // MARK: - Keychain
    
    func setEmail(email: String) {
        self.email = email
        keychain.set(email, forKey: "email")
    }
    
    func logout() {
        keychain.delete("email")
        self.email = nil
        self.favoriteMemes = []
    }
}

