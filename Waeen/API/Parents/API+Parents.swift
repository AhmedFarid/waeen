//
//  API+Parents.swift
//  Waeen
//
//  Created by farid on 3/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API_Parents: NSObject {

    class func infoStudent(completion: @escaping (_ error: Error?,_ sparParts: [studentInfo]?)-> Void) {
        
        let url = URLs.studentParent
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        let parameters = [
            "user_token": user_token,
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
                var products = [studentInfo]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = studentInfo.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func messageParent(url: String, completion: @escaping (_ error: Error?,_ sparParts: [massegesParent]?)-> Void) {
        
        //let url = URLs.sendMessageAdmin
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,nil)
            return
        }
        
        
        let parameters = [
            "user_token": user_token,
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
                var products = [massegesParent]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = massegesParent.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func sendmassage(title: String, body: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.messageParent
        guard let user_token = helper.getAPIToken().user_token else {
            completion(nil,false,nil)
            return
        }
        
        print(url)
        let parameters = [
            "user_token": user_token,
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
    
}
