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

final class vendoAnnoutation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class adminHomeVC: UIViewController {
    
    
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var mapp: MKMapView!
    
    let ref = Database.database().reference().child(helper.getAPIToken().user_token ?? "")
    var buss = [DataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        collection.delegate = self
        collection.dataSource = self
        getbus()
        
        
    }
    
    func busInmap(){
    }
    
    func getbus() {
        print(ref)
        ref.observe(.value) { (snapshot: DataSnapshot) in
            self.buss = []
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                self.buss.append(rest)
            }
            
            self.collection.reloadData()
            if let data = snapshot.value as? [String:AnyObject]{
                for value in data.values {
                     if let busName = value["busName"] as? String,let speed = value["speed"] as? Int,let busNumber = value["busNumber"] as? String,let lat = value["lat"] as? String, let lng = value["lng"] as? String,let supervisorName = value["supervisorName"] as? String {
                        self.mapp.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                        
                        let mitCoordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lng) ?? 0.0)

                        let mitAnnotation = vendoAnnoutation(coordinate: mitCoordinate, title: "\(busName)\n\(busNumber)", subtitle: "\(speed)\n\(supervisorName)")
                        
                        self.mapp.addAnnotation(mitAnnotation)
                        self.mapp.setRegion(mitAnnotation.region, animated: true)
                        self.mapp.setCenter(mitCoordinate, animated: true)
                    }
                    
                }
            }
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
            
            mapp.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            
            let mitCoordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lng) ?? 0.0)
            
            let mitAnnotation = vendoAnnoutation(coordinate: mitCoordinate, title: "\(busName)\n\(busNumber)", subtitle: "\(speed)\n\(supervisorName)")
            mapp.addAnnotation(mitAnnotation)
            mapp.setRegion(mitAnnotation.region, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: collectionView.frame.height)
    }
}

extension adminHomeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let vendoAnnoutationView    = mapp.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            vendoAnnoutationView.image = UIImage(named: "Group 14")
            vendoAnnoutationView.animatesWhenAdded = true
            vendoAnnoutationView.titleVisibility = .adaptive
            vendoAnnoutationView.titleVisibility = .adaptive
            return vendoAnnoutationView
        }
        return nil
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
