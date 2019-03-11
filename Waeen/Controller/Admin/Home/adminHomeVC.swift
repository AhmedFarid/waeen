//
//  adminHomeVC.swift
//  Waeen
//
//  Created by farid on 3/6/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Firebase

class adminHomeVC: UIViewController {
    
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    let ref = Database.database().reference().child(helper.getAPIToken().user_token ?? "")
    var buss = [DataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        getbus()
    }
    
    func getbus() {
        print(ref)
//        ref.observe(.childAdded) { (snapshot: DataSnapshot) in
//            self.buss.append(snapshot)
//            print("xxx\(self.buss)")
//            self.collection.performBatchUpdates({ () -> Void in
//                let ip = NSIndexPath(row: self.buss.count-1, section: 0)
//                self.collection.insertItems(at: [ip as IndexPath])
//            }, completion:nil)
//        }
//
        ref.observe(.value) { (snapshot: DataSnapshot) in
            self.buss = []
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                self.buss.append(rest)
            }
            
            self.collection.reloadData()
        }
    }

}

extension adminHomeVC: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buss.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? homeCell {
            let snap = buss[indexPath.row]
            if let value = snap.value as? [String: AnyObject],let action = value["action"] as? String,let busName = value["busName"] as? String,let speed = value["speed"] as? Int{
                cell.name.text = busName
                cell.speed.text = "\(speed)"
                cell.stutes.text = action
            }
            return cell
    }else {
    return homeCell()
    }
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snap = buss[indexPath.row]
        if let value = snap.value as? [String: AnyObject],let action = value["action"] as? String,let busName = value["busName"] as? String,let speed = value["speed"] as? Int,let busNumber = value["busNumber"] as? String,let lat = value["lat"] as? String, let lng = value["lng"] as? String,let supervisorName = value["supervisorName"] as? String{
            print(busName)
            print("\(speed)")
            print(action)
            print(busNumber)
            print(lat)
            print(lng)
            print(supervisorName)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: collectionView.frame.height)
    }
}



//a1lqJRDgkmjLvbg5LhTyw3wybh3z0GSqMKYE8Raotl4aIzltdvDP0X7yizqm
//action:
//"Start"
//busName:
//"الاهلى "
//busNumber:
//"1907"
//lat:
//"30.0583854"
//lng:
//"31.2080036"
//speed:
//0
//supervisorName:
//"Ahmed Mahmoud"
