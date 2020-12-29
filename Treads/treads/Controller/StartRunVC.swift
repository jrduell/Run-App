//
//  FirstViewController.swift
//  treads
//
//  Created by Jacob Duell on 12/24/20.
//

import UIKit
import MapKit

//notice that StartRunVC inherits from LocationVC, which inherits from UIViewController
//additionally, StartRunVC also conforms to the MKMapViewDelegate
class StartRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerDidChangeAuthorization(manager!)
        mapView.delegate = self //this is the mapView delegate, the CurrentRunVC doesn not require the mapview to be shown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //every time this view appears, delegate is assigned to this one
        manager?.delegate = self // as? CLLocationManagerDelegate
        manager?.startUpdatingLocation()
    }
    
    //When the CurrentRunVC is loaded, stop updating location and assign the location manager delegate to CurrentRunVC
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    
    
    @IBAction func centerLocationBtnTapped(_ sender: Any) {
    }
    
    

}

//exhaustive cases of location authorization status
extension StartRunVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case  .authorizedWhenInUse, .authorizedAlways:
                mapView.showsUserLocation = true
                mapView.userTrackingMode = .follow
                break
            case .denied, .restricted:
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                break
            default:
                break
            }
        }
    }
}
