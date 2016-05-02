//
//  ViewController.swift
//  openSkateIOS
//
//  Created by Nick Eliason on 1/28/16.
//  Copyright © 2016 openSkate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var initialTouchYCoord: CGFloat = 0.0
    let neutralZoneRange = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func panAction(sender: UIPanGestureRecognizer) {
        if sender.state == .Began {
            initialTouchYCoord = sender.locationInView(self.view).y
        } else if sender.state == .Ended {
            label.text = "Accel: 0%"
        } else {
            let yLocation = sender.locationInView(self.view).y
            let accelerationPercentage: CGFloat
            if yLocation < initialTouchYCoord {
                accelerationPercentage = (initialTouchYCoord - sender.locationInView(self.view).y) / initialTouchYCoord
            } else {
                let viewHeight = self.view.frame.size.height
                accelerationPercentage = -((sender.locationInView(self.view).y - initialTouchYCoord) / (viewHeight - initialTouchYCoord))
            }
            let accelerationPercentageInt = Int(accelerationPercentage * 100)
            label.text = "Accel: \(String(accelerationPercentageInt))%"
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPress(sender: UIButton) {
        label.text = "new text"
    }
}

