//
//  notificationsVC.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class notificationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifatcitonss = [notfications]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshSentMasseges()
    }
    
    @objc private func handleRefreshSentMasseges() {
        API_Masseges.notification{ (error: Error?, notifatcitonss: [notfications]?) in
            if let notifatcitonss = notifatcitonss {
                self.notifatcitonss = notifatcitonss
                print("xxx\(self.notifatcitonss)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension notificationsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifatcitonss.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? notifactionCell {
            let notifatciton = notifatcitonss[indexPath.item]
            cell.configuerCell(prodect: notifatciton)
            return cell
        }else {
            return notifactionCell()
        }
    }
}
