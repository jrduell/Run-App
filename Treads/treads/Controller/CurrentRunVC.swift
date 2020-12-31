//
//  CurrentRunVC.swift
//  treads
//
//  Created by Jacob Duell on 12/29/20.
//

import UIKit
import MapKit

class CurrentRunVC: LocationVC {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var swipeBGImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var timer = Timer()
    
    var runDistance = 0.0
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        endRun()
    }
    
    func startRun() {
        manager?.startUpdatingLocation()
        startTimer()
    }
    
    func endRun() {
        manager?.stopUpdatingLocation()
    }
    
    func startTimer() {
        durationLabel.text = counter.stringTimeFormatHHMMSS()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        counter += 1
        durationLabel.text = counter.stringTimeFormatHHMMSS()
    }
    
    @IBAction func pauseRunButtonTapped(_ sender: Any) {
        
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        let minAdjust: CGFloat = 80
        let maxAdjust: CGFloat = 127.5
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImageView.center.x - minAdjust) && sliderView.center.x <= (swipeBGImageView.center.x + maxAdjust) {
                    //update position of slider view image
                    sliderView.center = CGPoint(x: sliderView.center.x + translation.x, y: sliderView.center.y)
                } else if sliderView.center.x >= (swipeBGImageView.center.x + maxAdjust) {
                    //don't let slider get too far right
                    sliderView.center.x = swipeBGImageView.center.x + maxAdjust
                } else {
                    //don't let slider get too far left
                    sliderView.center.x = swipeBGImageView.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            } else if sender.state == UIGestureRecognizer.State.ended && sliderView.center.x < (swipeBGImageView.center.x + maxAdjust) {
                UIView.animate(withDuration: 0.1) {
                    //reset slider to left if not all the way to right
                    sliderView.center.x = self.swipeBGImageView.center.x - minAdjust            }
            } else if sender.state == UIGestureRecognizer.State.ended && sliderView.center.x >= (swipeBGImageView.center.x + maxAdjust) {
                //dismiss view if user lets go at full right position
                //End run code goes here
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}

extension CurrentRunVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case  .authorizedWhenInUse, .authorizedAlways:
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations[0]
        } else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            distanceLabel.text = "\(runDistance.metersToMiles(decimalAccuracy: 2))"
        }
        
        lastLocation = locations.last
    }
    
}

