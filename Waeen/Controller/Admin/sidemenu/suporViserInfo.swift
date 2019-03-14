//
//  suporViserInfo.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class suporViserInfo: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var supervisoers = [supervisorsInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshSentMasseges()
    }
    
    @objc private func handleRefreshSentMasseges() {
        API_Masseges.infoSchools{ (error: Error?, supervisoers: [supervisorsInfo]?) in
            if let supervisoers = supervisoers {
                self.supervisoers = supervisoers
                print("xxx\(self.supervisoers)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension suporViserInfo: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supervisoers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? superVisoersCell {
            let attendancessz = supervisoers[indexPath.item]
            cell.configuerCell(prodect: attendancessz)
            return cell
        }else {
            return superVisoersCell()
        }
    }
}

