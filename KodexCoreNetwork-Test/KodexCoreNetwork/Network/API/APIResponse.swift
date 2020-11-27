
//
//  APIContants.swift
//  BandPass
//
//  Created by Jassie on 12/01/16.
//  Copyright © 2016 eeGames. All rights reserved.
//

import Foundation
import SwiftyJSON

extension API{
    func handleResponse(parameters : JSON?) -> Response {
        let message = parameters?.dictionary?["message"]?.rawValue as? String ?? ""
        let isSuccess = parameters?.dictionary?["status"]?.rawValue as? Bool ?? false
        let data = parameters?.dictionary?["data"]
        return Response.init(data: data as? AnyObject, message, isSuccess)
    }
    
}

enum APIValidation : String{
    case None
    case Success = "1"
    case ServerIssue = "500"
    case Failed = "0"
    case TokenInvalid = "401"
}

enum APIResponse {
    case Success(Response?)
    case Failure(String?)
    case Progress(Double?)
}

class Response {
    var data :AnyObject?
    var message:String = ""
    var isSuccess:Bool = false
    init(data:AnyObject?,_ message:String = "",_ isSuccess:Bool = false) {
        self.data = data
        self.message = message
        self.isSuccess = isSuccess
    }
}

func decodeJson<T: Decodable>(_ dataJS: JSON?) -> T?{
    if let data = dataJS?.rawString()?.data(using: .utf8){
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch {
            print(error as Any)
            return nil
        }
    }else{
        print("Error Parsing")
        return nil
    }
}
func decodeJson<T: Decodable>(_ dataJS: String?) -> T?{
    if let data = dataJS?.data(using: .utf8){
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch {
            print(error as Any)
            return nil
        }
    }else{
        print("Error Parsing")
        return nil
    }
}




//MARK: Example decoding json
/**
 //            if let jsonData = data?.rawString()?.data(using: .utf8)
 //            {
 //                do {
 //                    let userObj = try JSONDecoder().decodeJson([].self, from: jsonData)
 //                    return Response.init(data: userObj as AnyObject?,message)
 //                }catch{
 //                    print(error as Any)
 //                    return Response.init(data: []() as AnyObject,message)
 //                }
 //            }else{
 //                return Response.init(data: []() as AnyObject,message)
 //            }
 //        }
 */
