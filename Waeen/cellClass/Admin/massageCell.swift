//
//  massageCell.swift
//  Waeen
//
//  Created by farid on 3/13/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class massageCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    
    func configuerCell(prodect: messages) {
        
        self.name.text = prodect.receiver
        self.title.text = prodect.title
        self.date.text = prodect.date
        
    }
    
}
