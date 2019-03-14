//
//  messages.swift
//  Waeen
//
//  Created by farid on 3/13/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON

class messages: NSObject {
    
    var id: String
    var receiver: String
    var title: String
    var body: String
    var schoolName: String
    var date: String
    
    init?(dict: [String: JSON]){
        
        if let receiver = dict["receiver"]?.string {
            self.receiver = receiver
            
            
        }else if let sender = dict["sender"]?.string{
            self.receiver = sender
        }else {
            self.receiver = ""
        }
        
        guard let id = dict["id"]?.string,let title = dict["title"]?.string,let body = dict["body"]?.string,let schoolName = dict["schoolName"]?.string,let date = dict["date"]?.string  else {return nil}
        
        self.id = id
        self.title = title
        self.body = body
        self.schoolName = schoolName
        self.date = date
        
        
        
        
    }
}

class newMasseges: NSObject {
    
    var id: String
    var name: String
    var image: String
    var phone: String
    var address: String
    
    init?(dict: [String: JSON]){
        
        guard let id = dict["id"]?.string,let name = dict["name"]?.string,let image = dict["image"]?.string,let phone = dict["phone"]?.string,let address = dict["address"]?.string  else {return nil}
        self.id = id
        self.name = name
        self.image = image
        self.phone = phone
        self.address = address
    }
}

class notfications: NSObject {
    
    var title: String
    var message: String
    var data: String
    
    init?(dict: [String: JSON]){
        
        guard let title = dict["title"]?.string,let message = dict["message"]?.string,let data = dict["data"]?.string else {return nil}
        self.title = title
        self.message = message
        self.data = data
    }
}

class Attendances: NSObject {
    
    var parentName: String
    var studentName: String
    var title: String
    var message: String
    var supervisorName: String
    var from: String
    var to: String
    var data: String
    
    init?(dict: [String: JSON]){
        
        guard let parentName = dict["parentName"]?.string,let studentName = dict["studentName"]?.string,let title = dict["title"]?.string,let message = dict["message"]?.string,let supervisorName = dict["supervisorName"]?.string,let from = dict["from"]?.string,let to = dict["to"]?.string,let data = dict["data"]?.string  else {return nil}
        self.parentName = parentName
        self.studentName = studentName
        self.title = title
        self.message = message
        self.supervisorName = supervisorName
        self.from = from
        self.to = to
        self.data = data
    }
}


class supervisorsInfo: NSObject {
    
    var supervisorsName: String
    var supervisorsPhone: String
    var busesName: String
    var busesNumberBus: String
    var busesCapacity: String
    var routesName: String
    
    init?(dict: [String: JSON]){
        
        guard let supervisorsName = dict["supervisorsName"]?.string,let supervisorsPhone = dict["supervisorsPhone"]?.string,let busesName = dict["busesName"]?.string,let busesNumberBus = dict["busesNumberBus"]?.string,let busesCapacity = dict["busesCapacity"]?.string,let routesName = dict["routesName"]?.string  else {return nil}
        self.supervisorsName = supervisorsName
        self.supervisorsPhone = supervisorsPhone
        self.busesName = busesName
        self.busesNumberBus = busesNumberBus
        self.busesCapacity = busesCapacity
        self.routesName = routesName
    }
}

//
//
//
//
//
//
