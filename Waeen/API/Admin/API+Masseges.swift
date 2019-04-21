//
//  API+Masseges.swift
//  Waeen
//
//  Created by farid on 3/13/19.
//  Copyright © 2019 farid. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class API_Masseges: NSObject {
    
    class func send (type: String,url: String, completion: @escaping (_ error: Error?,_ sparParts: [messages]?)-> Void) {
        
        //let url = URLs.sendMessageAdmin
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        
        let parameters = [
            "user_token": user_token,
            "type": type
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [messages]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = messages.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    
    class func typeMessage (type: String, completion: @escaping (_ error: Error?,_ sparParts: [newMasseges]?)-> Void) {
        
        let url = URLs.typeMessage
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        
        let parameters = [
            "user_token": user_token,
            "type": type
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [newMasseges]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = newMasseges.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func sendmassage(type: String, id: String, title: String, body: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.messageAdmin
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,false,nil)
            return
        }
        
        print(url)
        let parameters = [
            "user_token": user_token,
            "type": type,
            "id": id,
            "title": title,
            "body": body
        ]
        
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let data = json["data"].string {
                    print(data)
                    completion(nil, true, data)
                }else  {
                    let data = json["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
    
    class func notification(completion: @escaping (_ error: Error?,_ sparParts: [notfications]?)-> Void) {
        
        let url = URLs.notification
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        guard let role = helper.getAPIToken().role else {
            completion(nil,nil)
            return
        }
        
        
        let parameters = [
            "user_token": user_token,
            "role": role
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [notfications]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = notfications.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func getAttendanceStudentss(completion: @escaping (_ error: Error?,_ sparParts: [Attendances]?)-> Void) {
        
        let url = URLs.getAttendanceStudent
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        guard let role = helper.getAPIToken().role else {
            completion(nil,nil)
            return
        }
        
        
        let parameters = [
            "user_token": user_token,
            "role": role
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [Attendances]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = Attendances.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    
    class func infoSchools(completion: @escaping (_ error: Error?,_ sparParts: [supervisorsInfo]?)-> Void) {
        
        let url = URLs.infoSchool
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        
        
        let parameters = [
            "user_token": user_token,
            "api_token": "1234"
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [supervisorsInfo]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = supervisorsInfo.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
}
