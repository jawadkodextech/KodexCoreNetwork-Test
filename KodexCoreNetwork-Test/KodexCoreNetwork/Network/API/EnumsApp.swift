//
//  EnumsApp.swift
//  CLEAQUES
//
//  Created by Namxu Ihseruq on 15/10/2020.
//

import Foundation

enum UserType:String,Codable {
    case Personal = "personal"
    case Vendor = "vendor"
}

enum SocialTypes:String,CaseIterable {
    case Facebook = "facebook"
    case Google = "google"
    case Apple = "apple"
    case None = ""
}

enum Gender:String,CaseIterable {
    case Male = "male"
    case Female = "female"
    case Other = "other"
}


enum TypeForgot :String,CaseIterable {
    case Phone = "phone"
    case Email = "email"
}

enum MediaType :String,CaseIterable {
    case Image = "image"
    case Video = "video"
    case Audio = "audio"
    case Document = "document"
    case Location = "location"
}

enum ReportType:String{
    case Harassment = "harassment"
    case Sharing = "Sharing inappropriate things"
    case HateSpeech = "Hate Speech"
    case Other = "Other"
    case BlockUser = "BlockOther"
}

enum ReportKind:String {
    case post = "post"
    case user = "user"
    case message = "message"
    case product = "product"
}

