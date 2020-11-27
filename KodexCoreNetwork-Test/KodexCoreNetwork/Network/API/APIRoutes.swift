
//
//  APIContants.swift
//  BandPass
//
//  Created by Jassie on 12/01/16.
//  Copyright © 2016 eeGames. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias OptionalDictionary = [String : Any]?
typealias OptionalDictionaryWithDicParam = [String : [String:Any]]?
typealias OptionalSwiftJSONParameters = [String : JSON]?

infix operator =>
infix operator =|
infix operator =<
infix operator =/

func =>(key : String, json : OptionalSwiftJSONParameters) -> String?{
    return json?[key]?.stringValue
}

func =<(key : String, json : OptionalSwiftJSONParameters) -> Double?{
    return json?[key]?.double
}

func =|(key : String, json : OptionalSwiftJSONParameters) -> [JSON]?{
    return json?[key]?.arrayValue
}

func =/(key : String, json : OptionalSwiftJSONParameters) -> Int?{
    return json?[key]?.intValue
}

prefix operator ¿
prefix func ¿(value : String?) -> String {
    return value.unwrap()
}


protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : Alamofire.HTTPMethod { get }
}



enum API {
    
    static func mapKeysAndValues(_ tempKeys : [String],_ tempValues : [Any]) -> [String : Any]{
        
        var params = [String : Any]()
        for (key,value) in zip(tempKeys,tempValues) {
            params[key] = value
        }
        return params
    }
    
    static func mapKeysAndValuesDic(_ tempKeys : [String],_ tempValues : [Any]) -> [String:[String:Any]]{
        var params = [String : [String:Any]]()
        for (key,value) in zip(tempKeys,tempValues) {
            if let itemValue = value as? [String:Any] {
                params[key] = itemValue
            }
        }
        return params
    }
    case login(email:String,password:String)
    case socialLogin(social_id:String,social_type:SocialTypes,email:String)
    case signup(name:String,email:String,password:String,
                phone:String,address1:String,address2:String,
                country:String,state:String,city:String,
                zip:String,lat:String,lng:String,
                dob:String,gender:Gender,reg_number:String,
                reg_certificate:String,profile_type:UserType,is_social:Bool,social_id:String,social_type:SocialTypes,profile_image:String)
    case verifyUser(email:String)
    case forgotPassword(reference:String)
    case recoverPassword(reference:String,type:TypeForgot,password:String)
    case user
    case logout
    case uploadMedia
    case getCategories
    case setCategories(interests:[Int])
    // POST Scenario
    case createOrUpdatePost(post_id:String,title:String,description:String,product_id:String,post_media:[Int])
    case deletePost(post_id:String)
    case uploadMediaPost(type:MediaType,ratio:String,amazon_path:String,amazon_thumbnail:String)
    case discardMedia(post_media:[Int])
    case likeUnlike(post_id:String)
    case getLikeList(post_id:String)
    case postComment(post_id:String,comment:String)
    case getComments(post_id:String,limit:String,offset:String)
    case getFeedPost(limit:String,offset:String,filter:String)
    case getUserPost(limit:String,offset:String,filter:String)
    // PRODUCT Scenario
    case getProductTypes
    case getProductVendors
    case createOrUpdateProduct(product_id:String,title:String,category_id:Int,description:String,
                               type_id:Int,vendor_id:Int,tags:String,
                               availability_start_date:String,availability_end_date:String,
                               sku:String,barcode_image:String,is_quantity_track:Int,
                               is_sell_out_stock:Int,quantity:Int,cost:Double,
                               price:Double,is_variable_tax:Int,is_physical:Int,
                               unit:String,measure:String,origin_country:String,hs_code:String,
                               variants:String,product_media:[Int])
    
    case uploadMediaProduct(type:MediaType,ratio:String,amazon_path:String,amazon_thumbnail:String)
    case discardMediaProduct(product_media:[Int])
    case deleteProduct(product_id:Int)
    case getUserProducts(limit:String,offset:String,user_id:Int)
    case getProducts(limit:String,offset:String,filter:String,type_id:Int)
    case profileUpdate(name:String,bio:String,profileImage:String)
    case resetPassword(pass:String,newPass:String)
    
    //Commans
    case report(id:Int,report_kind:ReportKind,report_type:ReportType,description:String)
    case bookmark(id:Int,type:ReportKind)
}


extension API : Router{
    
    var route : String {
        switch self {
        case .resetPassword:
            return APIPaths.resetPassword
        case .getProductVendors:
            return APIPaths.getProductVendors
        case .getProductTypes:
            return APIPaths.getProductTypes
        case .uploadMedia:
            return APIPaths.uploadMedia
        case .login:
            return APIPaths.login
        case .socialLogin:
            return APIPaths.socialLogin
        case .signup:
            return APIPaths.signup
        case .verifyUser:
            return APIPaths.verifyUser
        case .forgotPassword:
            return APIPaths.forgotPassword
        case .recoverPassword:
            return APIPaths.recoverPassword
        case .user:
            return APIPaths.user
        case .logout:
            return APIPaths.logout
        case .getCategories:
            return APIPaths.getCategories
        case .setCategories:
            return APIPaths.setCategories
        case .createOrUpdatePost:
            return APIPaths.createOrUpdatePost
        case .deletePost:
            return APIPaths.deletePost
        case .discardMedia:
            return APIPaths.discardMediaPost
        case .likeUnlike:
            return APIPaths.likeUnlike
        case .getLikeList:
            return APIPaths.getPostLikes
        case .postComment:
            return APIPaths.postComment
        case .getComments:
            return APIPaths.getPostComment
        case .getFeedPost:
            return APIPaths.getDashboardPost
        case .getUserPost:
            return APIPaths.getUserPost
        case .uploadMediaPost:
            return APIPaths.uploadMediaPost
        case .createOrUpdateProduct:
            return APIPaths.createOrUpdateProduct
        case .deleteProduct:
            return APIPaths.deleteProduct
        case .getUserProducts:
            return APIPaths.getUserProducts
        case .getProducts:
            return APIPaths.getProducts
        case .uploadMediaProduct:
            return APIPaths.uploadProductMedia
        case .discardMediaProduct:
            return APIPaths.discardProductMedia
        case .report:
            return APIPaths.report
        case .bookmark:
            return APIPaths.bookmark
        case .profileUpdate:
            return APIPaths.profileUpdate
        }
    }
    
    var baseURL : String {  return APIConstants.BasePath }
    
    var parameters : OptionalDictionary {
        let pm = formatParameters()
        
        return pm
    }
    
    func url() -> String {
        return (baseURL + route).RemoveSpace()
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        
        case .login,.socialLogin,.signup,.verifyUser,.forgotPassword,.recoverPassword,.uploadMedia,.setCategories,.report,.bookmark,.profileUpdate,.resetPassword:
            return .post
        case .user,.logout,.getCategories,.getProductTypes,.getProductVendors:
            return .get
            
        case .getUserPost,.getFeedPost,.getComments,.postComment,.getLikeList,.likeUnlike,.discardMedia,.uploadMediaPost,.deletePost,.createOrUpdatePost,.getProducts,.createOrUpdateProduct,.uploadMediaProduct,.discardMediaProduct,.deleteProduct,.getUserProducts:
            return .post
        }
    }
}

extension API {
    func formatParameters() -> OptionalDictionary {
        switch self {
        
        case .login(email: let email, password: let password):
            return API.mapKeysAndValues(APIParameterConstants.Auth.login,[email,password])
        case .socialLogin(social_id: let social_id, social_type: let social_type, email: let email):
            return API.mapKeysAndValues(APIParameterConstants.Auth.socialLogin,[social_id,social_type.rawValue,email])
        case .signup(name: let name, email: let email, password: let password, phone: let phone, address1: let address1, address2: let address2, country: let country, state: let state, city: let city, zip: let zip, lat: let lat, lng: let lng, dob: let dob, gender: let gender, reg_number: let reg_number, reg_certificate: let reg_certificate, profile_type: let profile_type, is_social: let is_social,social_id :let social_id,social_type :let social_type,profile_image:let profile_image):
            return API.mapKeysAndValues(APIParameterConstants.Auth.signup, [name,email,password,phone,address1,address2,country,state,city,zip,lat,lng,dob,gender.rawValue,reg_number,reg_certificate,profile_type.rawValue,is_social ? 1 : 0,social_id,social_type.rawValue,profile_image])//
        case .verifyUser(email: let email):
            return API.mapKeysAndValues(APIParameterConstants.Auth.verifyUser, [email])
        case .forgotPassword(reference: let reference):
            return API.mapKeysAndValues(APIParameterConstants.Auth.forgotPassword, [reference])
        case .recoverPassword(reference: let reference, type: let type, password: let password):
            return API.mapKeysAndValues(APIParameterConstants.Auth.recoverPassword, [reference,type.rawValue,password])
        case .setCategories(interests: let interests):
            return API.mapKeysAndValues(APIParameterConstants.Auth.setCategories, [interests])
            
        case .createOrUpdatePost(post_id: let post_id, title: let title, description: let description, product_id: let product_id, post_media: let post_media):
            return post_id.isEmpty ? API.mapKeysAndValues(APIParameterConstants.Post.createPost, [title,description,product_id,post_media]) : API.mapKeysAndValues(APIParameterConstants.Post.updatePost, [post_id,title,description,product_id,post_media])
        case .deletePost(post_id: let post_id):
            return API.mapKeysAndValues(APIParameterConstants.Post.deletePost, [post_id])
        case .uploadMediaPost(type: let type, ratio: let ratio, amazon_path: let amazon_path, amazon_thumbnail: let amazon_thumbnail):
            return API.mapKeysAndValues(APIParameterConstants.Post.uploadMedia, [type.rawValue,ratio,amazon_path,amazon_thumbnail])
        case .discardMedia(post_media: let post_media):
            return API.mapKeysAndValues(APIParameterConstants.Post.discardMedia, [post_media])
        case .likeUnlike(post_id: let post_id):
            return API.mapKeysAndValues(APIParameterConstants.Post.likeUnlike, [post_id])
        case .getLikeList(post_id: let post_id):
            return API.mapKeysAndValues(APIParameterConstants.Post.getLikeList, [post_id])
        case .postComment(post_id: let post_id, comment: let comment):
            return API.mapKeysAndValues(APIParameterConstants.Post.postComment, [post_id,comment])
        case .getComments(post_id: let post_id,limit: let limit, offset: let offset):
            return API.mapKeysAndValues(APIParameterConstants.Post.getComments, [post_id,limit,offset])
        case .getFeedPost(limit: let limit, offset: let offset, filter: let filter):
            return API.mapKeysAndValues(APIParameterConstants.Post.getFeedPost, [limit,offset,filter])
        case .getUserPost(limit: let limit, offset: let offset, filter: let filter):
            return API.mapKeysAndValues(APIParameterConstants.Post.getUserPost, [limit,offset,filter])
            
        case .createOrUpdateProduct(product_id:let product_id,title: let title, category_id: let category_id, description: let description, type_id: let type_id, vendor_id: let vendor_id, tags: let tags, availability_start_date: let availability_start_date, availability_end_date: let availability_end_date, sku: let sku, barcode_image: let barcode_image, is_quantity_track: let is_quantity_track, is_sell_out_stock: let is_sell_out_stock, quantity: let quantity, cost: let cost, price: let price, is_variable_tax: let is_variable_tax, is_physical: let is_physical, unit: let unit, measure: let measure, origin_country: let origin_country, hs_code: let hs_code, variants: let variants, product_media: let product_media):
            return product_id.isEmpty ? API.mapKeysAndValues(APIParameterConstants.Product.create, [title,category_id,description,type_id,vendor_id,tags,availability_start_date,availability_end_date,sku,barcode_image,is_quantity_track,is_sell_out_stock,quantity,cost,price,is_variable_tax,is_physical,unit,measure,origin_country,hs_code,variants,product_media]) : API.mapKeysAndValues(APIParameterConstants.Product.update, [product_id,title,category_id,description,type_id,vendor_id,tags,availability_start_date,availability_end_date,sku,barcode_image,is_quantity_track,is_sell_out_stock,quantity,cost,price,is_variable_tax,is_physical,unit,measure,origin_country,hs_code,variants,product_media])
        case .uploadMediaProduct(type: let type, ratio: let ratio, amazon_path: let amazon_path, amazon_thumbnail: let amazon_thumbnail):
            return API.mapKeysAndValues(APIParameterConstants.Product.uploadMedia, [type.rawValue,ratio,amazon_path,amazon_thumbnail])
        case .discardMediaProduct(product_media: let product_media):
            return API.mapKeysAndValues(APIParameterConstants.Product.discardMedia, [product_media])
        case .deleteProduct(product_id: let product_id):
            return API.mapKeysAndValues(APIParameterConstants.Product.deleteProduct, [product_id])
        case .getUserProducts(limit: let limit, offset: let offset, user_id: let user_id):
            return API.mapKeysAndValues(APIParameterConstants.Product.getUserProducts, [limit,offset,user_id])
        case .getProducts(limit: let limit, offset: let offset, filter: let filter, type_id: let type_id):
            return API.mapKeysAndValues(APIParameterConstants.Product.getUserProducts, [limit,offset,filter,type_id])

        case .report(id: let id, report_kind: let report_kind, report_type: let report_type, description: let description):
            return API.mapKeysAndValues(APIParameterConstants.Report.report, [id,report_kind.rawValue,report_type.rawValue,description])
        
        case .user,.logout,.uploadMedia,.getCategories,.getProductTypes,.getProductVendors:
            return [:]
        case .bookmark(id: let id, type: let type):
            return API.mapKeysAndValues(APIParameterConstants.Report.bookmark, [id,type.rawValue])
        case .profileUpdate(name: let name, bio: let bio, profileImage: let profileImage):
            return API.mapKeysAndValues(APIParameterConstants.Profile.profileUpdate, [name,bio,profileImage])
        case .resetPassword(pass: let pass, newPass: let newPass):
            return API.mapKeysAndValues(APIParameterConstants.Auth.resetPassword, [pass,newPass])
        }
    }
    
    
}

