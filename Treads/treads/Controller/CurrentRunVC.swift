//
//  CurrentRunVC.swift
//  treads
//
//  Created by Jacob Duell on 12/29/20.
//

import UIKit

class CurrentRunVC: UIViewController {

    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseRunBtn: UIButton!
    @IBOutlet weak var endRunBtn: UIImageView!
    @IBOutlet weak var endRunLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func pauseRunButtonTapped(_ sender: Any) {
    }
    
}
