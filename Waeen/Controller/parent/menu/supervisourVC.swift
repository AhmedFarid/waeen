//
//  supervisourVC.swift
//  Waeen
//
//  Created by farid on 3/25/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class supervisourVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var students = [studentInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshstudents()
    }
    
    @objc private func handleRefreshstudents() {
        API_Parents.infoStudent{ (error: Error?, students: [studentInfo]?) in
            if let students = students {
                self.students = students
                print("xxx\(self.students)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension supervisourVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? superVisourescell {
            let attendancessz = students[indexPath.item]
            cell.configuerCell(prodect: attendancessz)
            return cell
        }else {
            return superVisourescell()
        }
    }
}

