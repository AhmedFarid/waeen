//
//  notifactionCell.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class notifactionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var data: UILabel!
    
    
    
    func configuerCell(prodect: notfications) {
        
        self.title.text = prodect.title
        self.message.text = prodect.message
        self.data.text = prodect.data
        
    }
  
}

