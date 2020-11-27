//
//  DataManegar.swift
//  Trecco
//
//  Created by Jassie on 11/11/19.
//  Copyright © 2019 Jhony. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class DataManager: NSObject {
    //
    var user: User?{
        set{
            self.saveUserPermanentally(newValue)
        }
        get{
            self.getPermanentlySavedUser()
        }
    }
    
    var token:String? {
        set(value) {
            if(value != nil){
                UserDefaults.standard.set(value, forKey: "Token")
            }
        }
        get {
            let stToken = UserDefaults.standard.string(forKey: "Token")
            if(stToken == nil){
                return nil
            }else if (stToken?.isEmpty ?? false) {
                return nil
            }else{
                return stToken
            }
        }
    }
    
    
    
    
    
    
    func saveUserPermanentally(_ item:User?) {
        if item != nil {
            let encodedData = try? JSONEncoder().encode(item)
            UserDefaults.standard.set(encodedData, forKey: kUserPrefKey)
        }
    }
    
    func getPermanentlySavedUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: kUserPrefKey),
            let userData = try? JSONDecoder().decode(User.self, from: data) {
            return userData
        } else {
            return nil
        }
    }
    
    func getScreenWidth() -> CGFloat {
        return CGFloat.init(UserDefaults.standard.double(forKey: "ScreenWidth"))
    }
    
    func setScreenWidth(value:CGFloat) {
        UserDefaults.standard.set(Double.init(value), forKey: "ScreenWidth")
    }
    
    func getScreenHeight() -> CGFloat {
        return CGFloat.init(UserDefaults.standard.double(forKey: "ScreenHeight"))
    }
    func setScreenHeight(value:CGFloat) {
        UserDefaults.standard.set(Double.init(value), forKey: "ScreenHeight")
    }
    
    
    
    
    
    
    var deviceToken:String = UIDevice.current.identifierForVendor!.uuidString
    
    static let sharedInstance = DataManager()
    
    func logoutUser() {
        user = nil
        self.resetDefaults()
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    
    var categories:[Category] {
        get {
            let defaults = UserDefaults.standard
            guard let playerData = defaults.object(forKey: "kCategories") as? Data else {
                return []
            }
            guard let player = try? PropertyListDecoder().decode([Category].self, from: playerData) else {
                return []
            }
            return player
        }
        set (newValue){
            let defaults = UserDefaults.standard
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: "kCategories")
        }
    }
    
    var productVendors:[Category] {
        get {
            let defaults = UserDefaults.standard
            guard let playerData = defaults.object(forKey: "kProductVendors") as? Data else {
                return []
            }
            guard let player = try? PropertyListDecoder().decode([Category].self, from: playerData) else {
                return []
            }
            return player
        }
        set (newValue){
            let defaults = UserDefaults.standard
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: "kProductVendors")
        }
    }
 
    
    var productTypes:[ProductTypes]{
        get {
            let defaults = UserDefaults.standard
            guard let playerData = defaults.object(forKey: "kProductTypes") as? Data else {
                return []
            }
            guard let player = try? PropertyListDecoder().decode([ProductTypes].self, from: playerData) else {
                return []
            }
            return player
        }
        set (newValue){
            let defaults = UserDefaults.standard
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: "kProductTypes")
        }
    }
}
