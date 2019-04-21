//
//  massgeCells.swift
//  Waeen
//
//  Created by farid on 3/25/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class massgeCells: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    
    func configuerCell(prodect: massegesParent) {
        
        self.name.text = prodect.receiver
        self.title.text = prodect.title
        self.date.text = prodect.date
        
    }
}
