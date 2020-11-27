
//
//  APIContants.swift
//  BandPass
//
//  Created by Jassie on 12/01/16.
//  Copyright © 2016 eeGames. All rights reserved.
//

import Foundation
import Alamofire

func print(_ items: Any...) {
    #if DEBUG
    Swift.print(items[0])
    #endif
}

internal struct Build{
    static let isProduction = 0
}

internal struct APIConstants {
    //    static let BasePath = "http://139.162.3.157/trecco/"// old
    static let SocketURL = "http://139.162.3.157:5415"//"http://139.162.3.157:5510"
//    static let BasePath = "http://ruiz.dev4.ovh/wp-json/api/"// new
    static let BasePath = "http://45.56.122.34/cleaques/"
    static let BasePathDeepLink = "https://trecco.codingpixeldemo.com/trecco/"//https://www.codingpixel.com/trecco/"
    //    static let imageBasePath = "http://139.162.3.157/trecco/" // old
    static let imageBasePath = "https://sruser.fnnsolutions.com/"// new
    static let apiSecret = "hcduhfuf897985436&cbdhudbubev7eb"
    static let googlePhotosHost = "https://maps.googleapis.com/maps/api/place/photo"
    static func googlePhotoURL(photoReference:String, maxWidth:Int) -> URL? {
        return URL.init(string: "\(googlePhotosHost)?maxwidth=\(maxWidth)&key=\(placesKey)&photoreference=\(photoReference)")
    }
    static func shareDeepLink(id:String,type:String)-> String{
        return BasePathDeepLink + "details?id=\(id)&type=\(type)"
    }
}



internal struct APIPaths {
    // API Paths
    static let login = "api/auth/login"
    static let socialLogin = "api/auth/social_login"
    static let signup = "api/auth/signup"
    static let verifyUser = "api/auth/verify_user"
    static let user = "api/auth/user"
    static let logout = "api/auth/logout"
    static let forgotPassword = "api/auth/forgot_password"
    static let recoverPassword = "api/auth/recover_password"
    static let resetPassword = "api/reset_password"
    static let uploadMedia = "api/upload_media"
    static let getCategories = "api/get_categories"
    static let getProductTypes = "api/get_product_types"
    static let getProductVendors = "api/get_product_vendors"
    static let setCategories = "api/set_interests"
    static let profileUpdate = "api/update_profile"
    // Post End Ponts
    static let createOrUpdatePost = "api/update_post"
    static let deletePost = "api/delete_post"
    static let uploadMediaPost = "api/upload_post_media"
    static let discardMediaPost = "api/discard_post_media"
    static let likeUnlike = "api/like_unlike_post"
    static let getPostLikes = "api/get_post_likes"
    static let postComment = "api/comment_post"
    static let getPostComment = "api/get_post_comments"
    static let getDashboardPost = "api/dashboard_posts"
    static let getUserPost = "api/get_user_posts"
    // Product End Point
    static let createOrUpdateProduct = "api/update_product"
    static let uploadProductMedia = "api/upload_product_media"
    static let discardProductMedia = "api/discard_product_media"
    static let deleteProduct = "api/delete_product"
    static let getUserProducts = "api/get_user_products"
    static let getProducts = "api/get_products"
    
    //Commans
    static let report = "api/report"
    static let bookmark = "api/bookmark"
}



struct PKeys{
    //Paramaters
    static let email = "email"
    static let password = "password"
    static let social_id = "social_id"
    static let social_type = "social_type"
    static let name = "name"
    static let city = "city"
    static let country = "country"
    static let address1 = "address1"
    static let address2 = "address2"
    static let state = "state"
    static let zip = "zip"
    static let lat = "lat"
    static let lng = "lng"
    static let is_social = "is_social"
    static let profile_type = "profile_type"
    static let phone = "phone"
    static let dob = "dob"
    static let gender = "gender"
    static let reg_number = "reg_number"
    static let reg_certificate = "reg_certificate"
    static let reference = "reference"
    static let type = "type"
    static let profile_image = "profile_image"
    static let interests = "interests"
    
    static let post_id = "post_id"
    static let title = "title"
    static let description = "description"
    static let product_id = "product_id"
    static let post_media = "post_media"
    static let ratio = "ratio"
    static let amazon_path = "amazon_path"
    static let amazon_thumbnail = "amazon_thumbnail"
    static let comment = "comment"
    static let limit = "limit"
    static let offset = "offset"
    static let filter = "filter"
    static let category_id = "category_id"
    static let type_id = "type_id"
    static let vendor_id = "vendor_id"
    static let tags = "tags"
    static let availability_start_date = "availability_start_date"
    static let availability_end_date = "availability_end_date"
    static let sku = "sku"
    static let barcode_image = "barcode_image"
    static let is_quantity_track = "is_quantity_track"
    static let is_sell_out_stock = "is_sell_out_stock"
    static let quantity = "quantity"
    static let cost = "cost"
    static let price = "price"
    static let is_variable_tax = "is_variable_tax"
    static let is_physical = "is_physical"
    static let unit = "unit"
    static let measure = "measure"
    static let origin_country = "origin_country"
    static let hs_code = "hs_code"
    static let variants = "variants"
    static let product_media = "product_media"
    static let user_id = "user_id"
    
    static let ref_id = "ref_id"
    static let ref_type = "ref_type"
    static let report_type = "report_type"
    static let new_password = "new_password"
    //profileUpdate
//    static let name = "name"
//    static let profile_image = "profile_image"
    static let bio = "bio"
    
}


internal struct APIParameterConstants {
    
    struct Profile {
        static let profileUpdate = [PKeys.name,PKeys.bio,PKeys.profile_image]
    }
    
    struct Report{
        static let report = [PKeys.ref_id,PKeys.ref_type,PKeys.report_type,PKeys.description]
        static let bookmark = [PKeys.ref_id,PKeys.type]
    }
    
    struct Auth {
        static let login = [PKeys.email,PKeys.password]
        static let socialLogin = [PKeys.social_id,PKeys.social_type,PKeys.email]
        static let signup = [PKeys.name,PKeys.email,PKeys.password,
                             PKeys.phone,PKeys.address1,PKeys.address2,
                             PKeys.country,PKeys.state,PKeys.city,
                             PKeys.zip,PKeys.lat,PKeys.lng,
                             PKeys.dob,PKeys.gender,PKeys.reg_number,
                             PKeys.reg_certificate,PKeys.profile_type,PKeys.is_social,PKeys.social_id,PKeys.social_type,PKeys.profile_image]
        static let verifyUser = [PKeys.email]
        static let forgotPassword = [PKeys.reference]
        static let recoverPassword = [PKeys.reference,PKeys.type,PKeys.password]
        static let resetPassword = [PKeys.password,PKeys.new_password]
        static let setCategories = [PKeys.interests]
    }
    
    struct Post {
        static let createPost = [PKeys.title,PKeys.description,PKeys.product_id,PKeys.post_media]
        static let updatePost = [PKeys.post_id,PKeys.title,PKeys.description,PKeys.product_id,PKeys.post_media]
        static let deletePost = [PKeys.post_id]
        static let uploadMedia = [PKeys.type,PKeys.ratio,PKeys.amazon_path,PKeys.amazon_thumbnail]
        static let discardMedia = [PKeys.post_media]
        static let likeUnlike = [PKeys.post_id]
        static let getLikeList = [PKeys.post_id]
        static let postComment = [PKeys.post_id,PKeys.comment]
        static let getComments = [PKeys.post_id,PKeys.limit,PKeys.offset]
        static let getFeedPost = [PKeys.limit,PKeys.offset,PKeys.filter]
        static let getUserPost = [PKeys.limit,PKeys.offset,PKeys.filter]
    }
    
    struct Product {
        static let create = [PKeys.title,PKeys.category_id,PKeys.description,
                                            PKeys.type_id,PKeys.vendor_id,PKeys.tags,
                                            PKeys.availability_start_date,PKeys.availability_end_date,
                                            PKeys.sku,PKeys.barcode_image,PKeys.is_quantity_track,
                                            PKeys.is_sell_out_stock,PKeys.quantity,PKeys.cost,
                                            PKeys.price,PKeys.is_variable_tax,PKeys.is_physical,
                                            PKeys.unit,PKeys.measure,PKeys.origin_country,PKeys.hs_code,
                                            PKeys.variants,PKeys.product_media]
        static let update = [PKeys.product_id,PKeys.title,PKeys.category_id,PKeys.description,
                                            PKeys.type_id,PKeys.vendor_id,PKeys.tags,
                                            PKeys.availability_start_date,PKeys.availability_end_date,
                                            PKeys.sku,PKeys.barcode_image,PKeys.is_quantity_track,
                                            PKeys.is_sell_out_stock,PKeys.quantity,PKeys.cost,
                                            PKeys.price,PKeys.is_variable_tax,PKeys.is_physical,
                                            PKeys.unit,PKeys.measure,PKeys.origin_country,PKeys.hs_code,
                                            PKeys.variants,PKeys.product_media]
        static let uploadMedia = [PKeys.type,PKeys.ratio,PKeys.amazon_path,PKeys.amazon_thumbnail]
        static let discardMedia = [PKeys.product_media]
        static let deleteProduct = [PKeys.product_id]
        static let getUserProducts = [PKeys.limit,PKeys.offset,PKeys.user_id]
        static let getProducts = [PKeys.limit,PKeys.offset,PKeys.filter,PKeys.type_id]
    }
}

enum FileParamName :String{
    case PictureFile = "Attachment.File"
    case Media = "media"
    case IdProofFile = "IdProof.File"
    case ESignatureFile = "ESignature.File"
    case ReferenceAttachmentFile = "ReferenceAttachment.File"
}
enum FileSendType:String {
    case vendor_document = "vendor_document"
}
