//
//  parentHomeVC.swift
//  Waeen
//
//  Created by farid on 3/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class parentHomeVC: UIViewController {

    
    
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var mapp: MKMapView!
    var annotation = MKPointAnnotation()
    
    var busName = ""
    var speed = ""
    var busnumber = ""
    var action = ""
    var supervisorName = ""
    var kay = "xxx"
    
    
    var students = [studentInfo]()
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapp.delegate = self
        collection.delegate = self
        collection.dataSource = self
        handleRefreshstudents()
    }
    
    
    func bus(){
        ref?.observe(.value) { (snapshot: DataSnapshot) in
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
    
    
    @objc private func handleRefreshstudents() {
        API_Parents.infoStudent{ (error: Error?, students: [studentInfo]?) in
            if let students = students {
                self.students = students
                print("xxx\(self.students)")
                self.collection.reloadData()
            }
        }
        
    }
    
    @objc func goToInfo(){
        showAlert(title: "bus info", message: "bus name: \(busName)\nspeed: \(speed)\nbus number: \(busnumber) \naction: \(action)\nsupervisor name: \(supervisorName)")
    }
}

extension parentHomeVC: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? parentCell {
            let snap = students[indexPath.row]
            cell.configuerCell(prodect: snap)
            return cell
        }else {
            return parentCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bus = students[indexPath.row]
        let refbus = Database.database().reference().child("\(helper.getAPIToken().userTokenAdmin ?? "")/\(bus.supervisorsUserToken)")
        self.ref = refbus
        ref?.removeAllObservers()
        self.bus()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: collectionView.frame.height)
    }
}


extension parentHomeVC: MKMapViewDelegate {
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
            detailButton.addTarget(self, action: #selector(parentHomeVC.goToInfo), for: .touchDown)
            annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
