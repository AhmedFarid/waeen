//
//  attandenceVC.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class attandenceCell: UITableViewCell {
    
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var supervisorName: UILabel!
    @IBOutlet weak var to: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    
    
    func configuerCell(prodect: Attendances) {
        
        self.data.text = prodect.data
        self.from.text = prodect.from
        self.message.text = prodect.message
        self.parentName.text = prodect.parentName
        self.studentName.text = prodect.studentName
        self.supervisorName.text = prodect.supervisorName
        self.to.text = prodect.to
        self.title.text = prodect.title
        
    }
}
