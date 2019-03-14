//
//  attendanceVC.swift
//  Waeen
//
//  Created by farid on 3/14/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class attendanceVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var attendancesss = [Attendances]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshSentMasseges()
    }
    
    @objc private func handleRefreshSentMasseges() {
        API_Masseges.getAttendanceStudentss{ (error: Error?, attendancesss: [Attendances]?) in
            if let attendancesss = attendancesss {
                self.attendancesss = attendancesss
                print("xxx\(self.attendancesss)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension attendanceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendancesss.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? attandenceCell {
            let attendancessz = attendancesss[indexPath.item]
            cell.configuerCell(prodect: attendancessz)
            return cell
        }else {
            return attandenceCell()
        }
    }
}
