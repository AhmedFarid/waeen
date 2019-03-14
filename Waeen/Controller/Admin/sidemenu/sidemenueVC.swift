//
//  sidemenueVC.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class sidemenueVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text  = helper.getAPIToken().name
        self.role.text = helper.getAPIToken().role
    }
    
    @IBAction func logout(_ sender: Any) {
        helper.dleteAPIToken()
    }
}
