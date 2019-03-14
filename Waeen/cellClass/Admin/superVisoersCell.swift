//
//  superVisoersCell.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class superVisoersCell: UITableViewCell {

    @IBOutlet weak var supervisorsPhone: UILabel!
    @IBOutlet weak var supervisorsName: UILabel!
    @IBOutlet weak var busesName: UILabel!
    @IBOutlet weak var busesNumberBus: UILabel!
    @IBOutlet weak var busesCapacity: UILabel!
    @IBOutlet weak var routesName: UILabel!
    
    
    
    func configuerCell(prodect: supervisorsInfo) {
        
        self.supervisorsPhone.text = prodect.supervisorsPhone
        self.supervisorsName.text = prodect.supervisorsName
        self.busesName.text = prodect.busesName
        self.busesNumberBus.text = prodect.busesNumberBus
        self.busesCapacity.text = prodect.busesCapacity
        self.routesName.text = prodect.routesName
        
    }
}
