//
//  adminHomeVC.swift
//  Waeen
//
//  Created by farid on 3/6/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class adminHomeVC: UIViewController {
    
    
    let ref = Database.database().reference().child(helper.getAPIToken().user_token ?? "")
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var mapp: MKMapView!
    var annotation = MKPointAnnotation()
    
    var busName = ""
    var speed = ""
    var busnumber = ""
    var action = ""
    var supervisorName = ""
    var kay = "xxx"
    
   
    var buss = [DataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        mapp.delegate = self
        getbus()
        
    }
    
   fileprivate func bus(){
        let refbus = Database.database().reference().child("\(helper.getAPIToken().user_token ?? "")/\(kay)")
            print(refbus)
            refbus.observe(.value) { (snapshot: DataSnapshot) in
                if let data = snapshot.value as? [String:AnyObject]{
                    if let action = data["action"] as? String,let busName = data["busName"] as? String,let speed = data["speed"] as? Int,let busNumber = data["busNumber"] as? String,let lat = data["lat"] as? String, let lng = data["lng"] as? String,let supervisorName = data["supervisorName"] as? String{
                        print(supervisorName)
                        self.busnumber = busNumber
                        self.speed = "\(speed)"
                        self.action = action
                        self.busName = busName
                        print("xxxxxxx\(lat)")
                        //////////////
                        /////////////
                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        let lat = CLLocationDegrees(lat)
                        let long = CLLocationDegrees(lng)
                        let center = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
                        let region = MKCoordinateRegion(center: center, span: span)
                        self.mapp.setRegion(region, animated: true)
                        ////////
                        ///////
                        self.mapp.removeAnnotation(self.annotation)
                        self.annotation.coordinate = center
                        self.annotation.title = "bus name: \(busName)"
                        self.annotation.subtitle = "speed: \(speed) - bus number: \(busNumber)"
                        self.mapp.addAnnotation(self.annotation)
                }
            }
        }
    //refbus.removeAllObservers()
        
    }
    
    
    func getbus() {
        print(ref)
        ref.observe(.value) { (snapshot: DataSnapshot) in
            self.buss = []
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                self.buss.append(rest)
            }
            self.collection.reloadData()
        }
    }
    
    @objc func goToInfo(){
        showAlert(title: "bus info", message: "bus name: \(busName)\nspeed: \(speed)\nbus number: \(busnumber) \naction: \(action)\nsupervisor name: \(supervisorName)")
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
                cell.name.text = "bus name: \(busName)"
                cell.speed.text = "spped: \(speed)"
                cell.stutes.text = "action: \(action)"
            }
            return cell
        }else {
            return homeCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //bus().
        let refbus = Database.database().reference().child("\(helper.getAPIToken().user_token ?? "")/\(kay)")
        print(refbus)
        refbus.removeAllObservers()
        let snap = buss[indexPath.row]
        self.kay = snap.key
        bus()
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height)
    }
}

extension adminHomeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "Group 14")
            // if you want a disclosure button, you'd might do something like:
            //
            let detailButton = UIButton(type: .detailDisclosure)
            detailButton.addTarget(self, action: #selector(adminHomeVC.goToInfo), for: .touchDown)
            annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
