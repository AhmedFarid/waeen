//
//  API+AUTH.swift
//  Waeen
//
//  Created by farid on 3/6/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_AUTH: NSObject {
    
    class func login(email: String,password: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.login
        print(url)
        let parameters = [
            "api_token": "123456",
            "email": email,
            "password": password
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
                //family_member
                if let user_token = json["data"]["user_token"].string, let id = json["data"]["id"].string, let name = json["data"]["name"].string, let email = json["data"]["email"].string,let image = json["data"]["image"].string,let phone = json["data"]["phone"].string, let role = json["data"]["role"].string,let userTokenParent = json["data"]["userTokenParent"].string,let userTokenAdmin = json["data"]["userTokenAdmin"].string  {
                    print("user token \(user_token)")
                    helper.saveAPIToken(token: user_token, id: id, name: name, email: email, image: image, phone: phone, role: role, userTokenParent: userTokenParent, userTokenAdmin: userTokenAdmin)
                    completion(nil, true , nil)
                    
                    //parent
                }else if let userTokenParent = json["data"]["userTokenParent"].string, let id = json["data"]["id"].string, let name = json["data"]["name"].string, let email = json["data"]["email"].string,let image = json["data"]["image"].string,let phone = json["data"]["phone"].string, let role = json["data"]["role"].string,let userTokenAdmin = json["data"]["userTokenAdmin"].string,let message = json["data"]["message"].string  {
                    print("user token \(userTokenParent)")
                    helper.saveAPIToken(token: userTokenParent, id: id, name: name, email: email, image: image, phone: phone, role: role, userTokenParent: message, userTokenAdmin: userTokenAdmin)
                    completion(nil, true , nil)
                    
                    
                    //admin
                }else if let user_token = json["data"]["user_token"].string, let id = json["data"]["id"].string, let name = json["data"]["name"].string, let email = json["data"]["email"].string,let image = json["data"]["image"].string,let phone = json["data"]["phone"].string, let role = json["data"]["role"].string,let message = json["data"]["message"].string  {
                    print("user token \(user_token)")
                    helper.saveAPIToken(token: user_token, id: id, name: name, email: email, image: image, phone: phone, role: role, userTokenParent: message, userTokenAdmin: user_token)
                    completion(nil, true , nil)
                }else {
                    let data = json["data"]["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
    
    
    class func notifacation(player_ids: String, completion: @escaping (_ error: Error?, _ success: Bool, _ message: String?)->Void) {
        
        let url = URLs.playerIds
        guard let userToken = helper.getAPIToken().user_token else {
            completion(nil,false,nil)
            return
        }
        let parameters = [
            "player_ids": player_ids,
            "user_token": userToken,
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
                if let user_token = json["data"]["user_token"].string {
                    print("user token \(user_token)")
                    //helper.saveAPIToken(token: user_token)
                    completion(nil, true, nil)
                }else {
                    let message = json["data"]["message"].string
                    print(message ?? "no")
                    completion(nil, true, message)
                }
                
            }
        }
    }
}
