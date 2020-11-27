//
//  User.swift
//  Trecco
//
//  Created by Jassie on 11/11/19.
//  Copyright © 2019 Jhony. All rights reserved.
//

import Foundation
import GoogleSignIn
import FacebookLogin
import SwiftyJSON
import AuthenticationServices

class User :  Codable{
    
    
    
    var email_verified_at:String? = ""
    var phone_verified_at:String? = ""
    var date_of_birth:String? = ""
    var gender:String? = ""
    var reg_number:String? = ""
    var reg_certificate:String? = ""
    var profile_id:Int? = 0
    var stripe_payout_account_id:String? = ""
    var stripe_express_dashboard_url:String? = ""
    var social_id:String? = ""
    var social_type:String? = ""
    var created_at:String? = ""
    var updated_at:String? = ""
    var phone:String? = ""
    var token:String? = ""
    var id : Int? = 0
    var first_name:String? = ""
    var last_name:String? = ""
    var fullName:String {
        return "\(self.first_name ?? "") \(self.last_name ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var profile:Profile? = Profile()
    var userDemoId:String? = ""
    var pic:String? = ""
    var email:String? = ""
    var userType:UserType? {
        return self.profile?.profile_type == "personal" ? .Personal : .Vendor
    }
    static let currentUser: User = {
        let user = User()
        user.userDemoId = "23333"
        return user
    }()
    
    
    
    
    static func generateUserFromFacebook(response:[String:Any])  -> User {
        let user = User()
        user.email = response["email"] as? String ?? ""
        user.token = response["id"] as? String ?? ""
        user.first_name = response["name"] as? String ?? ""
        let fullname = user.first_name
        let firstname = fullname?.components(separatedBy: " ").first
        let lastname = fullname?.components(separatedBy: " ").last
        user.first_name = firstname?.capitalized
        user.last_name = lastname?.capitalized
        user.pic = "http://graph.facebook.com/\((response["id"] as! String))/picture?type=large"
        return user
    }
    
    func genrateUserFromGoogle(googleUser :  GIDGoogleUser?) -> User {
        let userObj = User()
        userObj.token =  googleUser!.authentication.accessToken
        let googleUsername = googleUser!.profile.name
        let firstname = googleUsername?.components(separatedBy: " ").first
        let lastname = googleUsername?.components(separatedBy: " ").last
        userObj.token = googleUser!.userID
        userObj.first_name = firstname?.capitalized
        userObj.last_name = lastname?.capitalized
        userObj.email = googleUser?.profile.email ?? ""
        userObj.pic = googleUser?.profile.imageURL(withDimension: 1024)?.absoluteString ?? ""
        return userObj
    }
    
    
    @available(iOS 13.0, *)
    func genrateUserFromApple(appleUser :  ASAuthorizationAppleIDCredential?) -> User {
        let userObj = User()
        let userIdentifier = appleUser?.user
        userObj.token = userIdentifier ?? ""
        userObj.first_name = appleUser?.fullName?.givenName
        userObj.last_name = appleUser?.fullName?.familyName
        userObj.email = appleUser?.email
        userObj.pic = ""
        return userObj
    }
}

class Profile:Codable {
    var id:Int? = 0
    var name:String? = "Demo User"
    var user_id:Int? = 0
    var bio:String? = ""
    var profile_image:String? = ""
    var image_ratio:String? = ""
    var address_id:Int? = 0
    var is_online:Int? = 0
    var profile_type:String? = ""
    var is_approved:Int? = 0
    var created_at:String? = ""
    var updated_at:String? = ""
    var userType:UserType? {
        return profile_type == "personal" ? .Personal : .Vendor
    }
}

class Category:Codable,Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    var id:Int? = 0
    var slug:String? = ""
    var name:String? = ""
    var icon:String? = ""
    var created_at:String? = ""
    var updated_at:String? = ""
}

class ProductTypes:Codable,Equatable  {
    
    static func == (lhs: ProductTypes, rhs: ProductTypes) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id:Int? = 0
    var category_id:Int? = 0
    var slug:String? = ""
    var name:String? = ""
    var icon:String? = ""
    var created_at:String? = ""
    var updated_at:String? = ""
    var category:Category? = nil
}
