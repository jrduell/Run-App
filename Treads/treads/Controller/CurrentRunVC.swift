//
//  CurrentRunVC.swift
//  treads
//
//  Created by Jacob Duell on 12/29/20.
//

import UIKit

class CurrentRunVC: LocationVC {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var swipeBGImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
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
    @IBAction func pauseRunButtonTapped(_ sender: Any) {
    }
    
}

