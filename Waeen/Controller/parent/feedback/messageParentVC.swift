//
//  messageParentVC.swift
//  Waeen
//
//  Created by farid on 3/25/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class messageParentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sentInpox: UISegmentedControl!
    
    var massages = [massegesParent]()
    var url = URLs.sendMessageParent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshSentMasseges()
    }
    
    @IBAction func sendiboxAction(_ sender: Any) {
        switch sentInpox.selectedSegmentIndex {
        case 0:
            self.url = URLs.sendMessageParent
            handleRefreshSentMasseges()
        case 1:
            self.url = URLs.inboxMessageParent
            handleRefreshSentMasseges()
        default:
            break;
        }
    }
    
    @objc private func handleRefreshSentMasseges() {
        API_Parents.messageParent(url: url){ (error: Error?, massages: [massegesParent]?) in
            if let massages = massages {
                self.massages = massages
                print("xxx\(self.massages)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension messageParentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? massgeCells {
            let massage = massages[indexPath.item]
            cell.configuerCell(prodect: massage)
            return cell
        }else {
            return massgeCells()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "suge", sender: massages[indexPath.row])
        print("no")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? newMessageVC{
            if let sub = sender as? massegesParent{
                destaiantion.type = sub.receiver
                destaiantion.namess = helper.getAPIToken().name ?? ""
                destaiantion.titless = sub.title
                destaiantion.messagess = sub.body
                destaiantion.x = "xx"
                
            }
        }
    }
}
