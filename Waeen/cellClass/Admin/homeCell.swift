//
//  homeCell.swift
//  Waeen
//
//  Created by farid on 3/6/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit


@IBDesignable
class homeCell: UICollectionViewCell {
    
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
