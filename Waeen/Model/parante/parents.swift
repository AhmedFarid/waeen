//
//  API+Parent.swift
//  Waeen
//
//  Created by farid on 3/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON



class studentInfo: NSObject {
    
    var studentsId: String
    var studentsName: String
    var studentsAge: String
    var studentsGender: String
    var studentsImage: String
    var busesName: String
    var numberBus: String
    var routesName: String
    var supervisorsName: String
    var supervisorsGender: String
    var supervisorsPhone: String
    var supervisorsUserToken: String
    var driversName: String
    var driversPhone: String
    
    
    init?(dict: [String: JSON]){
        
        guard let studentsId = dict["studentsId"]?.string,let studentsName = dict["studentsName"]?.string,let studentsAge = dict["studentsAge"]?.string,let studentsGender = dict["studentsGender"]?.string,let studentsImage = dict["studentsImage"]?.string,let busesName = dict["busesName"]?.string,let numberBus = dict["numberBus"]?.string,let routesName = dict["routesName"]?.string,let supervisorsName = dict["supervisorsName"]?.string,let supervisorsGender = dict["supervisorsGender"]?.string,let supervisorsPhone = dict["supervisorsPhone"]?.string,let supervisorsUserToken = dict["supervisorsUserToken"]?.string,let driversName = dict["driversName"]?.string,let driversPhone = dict["driversPhone"]?.string  else {return nil}
        
        self.studentsId = studentsId
        self.studentsName = studentsName
        self.studentsAge = studentsAge
        self.studentsGender = studentsGender
        self.studentsImage = studentsImage
        self.busesName = busesName
        self.numberBus = numberBus
        self.routesName = routesName
        self.supervisorsName = supervisorsName
        self.studentsName = studentsName
        self.supervisorsGender = supervisorsGender
        self.supervisorsUserToken = supervisorsUserToken
        self.driversName = driversName
        self.driversPhone = driversPhone
        self.supervisorsPhone = supervisorsPhone
    }
}

class massegesParent: NSObject {
    
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
        
        guard let id = dict["id"]?.string,let title = dict["title"]?.string,let body = dict["body"]?.string,let schoolName = dict["schoolName"]?.string,let date = dict["date"]?.string else {return nil}
        
        self.id = id
        self.title = title
        self.body = body
        self.date = date
        self.schoolName = schoolName
        
        
    }
}
