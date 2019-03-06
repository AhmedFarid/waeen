//
//  helper.swift
//  Waeen
//
//  Created by farid on 3/6/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class helper: NSObject {
    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        var vc: UIViewController
        if getAPIToken().user_token == nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            vc = sb.instantiateInitialViewController()!
        }else if getAPIToken().role == "admin" {
            let sb = UIStoryboard(name: "Admin", bundle: nil)
            vc = sb.instantiateInitialViewController()!
        }else if getAPIToken().role == "parent" {
            let sb = UIStoryboard(name: "family", bundle: nil)
            vc = sb.instantiateInitialViewController()!
        }else {
            let sb = UIStoryboard(name: "famliymember", bundle: nil)
            vc = sb.instantiateInitialViewController()!
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func dleteAPIToken() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "user_token")
        def.removeObject(forKey: "id")
        def.removeObject(forKey: "name")
        def.removeObject(forKey: "email")
        def.removeObject(forKey: "image")
        def.removeObject(forKey: "phone")
        def.removeObject(forKey: "role")
        def.removeObject(forKey: "userTokenParent")
        def.removeObject(forKey: "userTokenAdmin")
        def.synchronize()
        
        restartApp()
    }
    
    class func saveAPIToken(token: String,id: String,name: String, email: String, image: String, phone: String, role: String, userTokenParent: String, userTokenAdmin: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.setValue(id, forKey: "id")
        def.setValue(name, forKey: "name")
        def.setValue(email, forKey: "email")
        def.setValue(image, forKey: "image")
        def.setValue(phone, forKey: "phone")
        def.setValue(role, forKey: "role")
        def.setValue(userTokenParent, forKey: "userTokenParent")
        def.setValue(userTokenAdmin, forKey: "userTokenAdmin")
        def.synchronize()
        
        restartApp()
    }
    
    class func getAPIToken() -> (user_token: String?,id: String?, name: String?, email: String?, image: String?, phone: String?, role: String?, userTokenParent: String?, userTokenAdmin: String?) {
        let def = UserDefaults.standard
        return (def.object(forKey: "user_token") as? String,def.object(forKey: "id") as? String,def.object(forKey: "name") as? String,def.object(forKey: "email") as? String,def.object(forKey: "image") as? String,def.object(forKey: "phone") as? String,def.object(forKey: "role") as? String,def.object(forKey: "userTokenParent") as? String,def.object(forKey: "userTokenAdmin") as? String)
    }
}
