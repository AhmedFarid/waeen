//
//  feedBackVC.swift
//  Waeen
//
//  Created by farid on 3/13/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class feedBackVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typesegment: UISegmentedControl!
    @IBOutlet weak var sentInpox: UISegmentedControl!
    
    var sents = [messages]()
    var type = "parent"
    var url = URLs.inboxMessageAdmin
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshSentMasseges()
    }
    
    
    
    @IBAction func sendiboxAction(_ sender: Any) {
        switch sentInpox.selectedSegmentIndex {
        case 0:
            self.url = URLs.sendMessageAdmin
            handleRefreshSentMasseges()
        case 1:
            self.url = URLs.inboxMessageAdmin
            handleRefreshSentMasseges()
        default:
            break;
        }
    }
    
    @IBAction func typeAction(_ sender: Any) {
        switch typesegment.selectedSegmentIndex {
        case 0:
            self.type = "parent"
            handleRefreshSentMasseges()
        case 1:
            self.type = "supervisor"
            handleRefreshSentMasseges()
        default:
            break;
        }
    }
    
    
    @objc private func handleRefreshSentMasseges() {
        API_Masseges.send(type: type, url: url){ (error: Error?, sents: [messages]?) in
            if let sents = sents {
                self.sents = sents
                print("xxx\(self.sents)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension feedBackVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? massageCell {
            let massage = sents[indexPath.item]
            cell.configuerCell(prodect: massage)
            return cell
        }else {
             return massageCell()
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            performSegue(withIdentifier: "suge", sender: sents[indexPath.row])
            print("no")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? newMessageVC{
            if let sub = sender as? messages{
                destaiantion.singleItem = sub
                destaiantion.type = type
            }
        }
    }
}
