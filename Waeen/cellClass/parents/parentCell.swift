//
//  parentCell.swift
//  Waeen
//
//  Created by farid on 3/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class parentCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stutes: UILabel!
    @IBOutlet weak var studentName : UILabel!
    
    
    func configuerCell(prodect: studentInfo) {
        
        self.name.text = prodect.busesName
        self.stutes.text = prodect.numberBus
        self.studentName.text = prodect.studentsName
        
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
