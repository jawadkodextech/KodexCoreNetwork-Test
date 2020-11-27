
//
// APIContants.swift
// BandPass

import Foundation
import SwiftyJSON
import Alamofire

typealias APICompletion = (APIResponse) -> ()

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func operationWithFile( withApi api : API ,fileUrl:[URL?]?,paramName: [FileParamName],type: [FileSendType], completion : @escaping APICompletion ){
        
        httpClient.withFile(withApi: api, fileUrl: fileUrl, paramName: paramName,type:type,progressCompletation: { (progress) in
            completion(APIResponse.Progress(progress))
        }, success: { (data,headers) in
            self.handleResponse(api:api,data:data,headers: headers,completion: completion)
        }) { (error,headers) in
            self.handleErrors(api:api,error:error,headers: headers,completion: completion)
        }
    }
    
    func removeCall(){
        httpClient.removeCall()
    }
    
    func opertationWithRequest ( withApi api : API , completion : @escaping APICompletion ) {
        
        httpClient.postRequest(withApi: api, success: { (data,headers) in
            self.handleResponse(api:api,data:data,headers: headers,completion: completion)
        }) { (error,headers) in
            self.handleErrors(api:api,error:error,headers: headers,completion: completion)
        }
    }
    
    private func handleErrors(api : API ,error:NSError,headers:Any, completion : @escaping APICompletion ){
        print("Url:\(api.url())\nParams: \(String(describing:api.parameters))\nResponse: \(error)\nHeaders: \(headers)")//
        completion(APIResponse.Failure(error.localizedDescription))
    }
    
    private func handleResponse(api:API,data:AnyObject?,headers:Any,completion : @escaping APICompletion){
        guard let response = data else {
            completion(APIResponse.Failure(""))
            return
        }
        let json = JSON(response)
        
        if let status = json.dictionaryValue["message"]?.stringValue,let isSuccess = json.dictionaryValue["status"]?.boolValue,!isSuccess {
            let data = json.dictionaryValue["data"]
            print("Url:\(api.url())\nParams: \(String(describing:api.parameters))\nResponse: \(data as Any)\nHeaders: \(headers)")//
            if let response:ErrorHandleDatum = decodeJson(data) {
                let dataItem = "\(response.email?.joined(separator: "\n") ?? ""),\(response.phone?.joined(separator: "\n") ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
                let message = "\(status)\n,\(dataItem.isEmpty ? "\(data as Any)" : "\(dataItem)")"
                completion(APIResponse.Failure(message))
            }else{
                completion(APIResponse.Failure(status))
            }
            return
        }
        let message = json.dictionary?["message"]?.rawValue as? String ?? ""
        let data = json.dictionary?["data"]
        if let status = data?.dictionary?["status"]?.int {
            completion(APIResponse.Failure("\(message)\nStatus : \(status)Headers: \(headers)"))
            return
        }
        if DataManager.sharedInstance.token != nil {
            if message == "Unauthenticated."{
                goToRoot(json: json, completion: completion)
                return
            }
        }
        completion(.Success(api.handleResponse(parameters: json)))
    }
    
    func goToRoot(json:JSON,completion : @escaping APICompletion ){
        completion(APIResponse.Failure("Current user did not login to the application!"))
        DataManager.sharedInstance.logoutUser()
    }
    
}

class ErrorModel :Codable {
//    "details" : null,
//       "validationErrors" : null,
    var code:Int? = 0
    var message:String? = ""
}

