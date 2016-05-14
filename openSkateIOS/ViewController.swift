//
//  ViewController.swift
//  openSkateIOS
//
//  Created by Nick Eliason on 1/28/16.
//  Copyright © 2016 openSkate. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var initialTouchYCoord: CGFloat = 0.0
    let neutralZoneRange: CGFloat = 30.0
    var viewHeight: CGFloat = 0.0
    var hasVibrated = false  // so out of range vibration only occurs once
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeight = self.view.frame.size.height
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func panAction(sender: UIPanGestureRecognizer) {
        if sender.state == .Began {
            initialTouchYCoord = sender.locationInView(self.view).y
        } else if sender.state == .Ended {
            label.text = "Accel: 0%"
            hasVibrated = false
        } else {
            let yLocation = sender.locationInView(self.view).y
            var accelerationPercentage: CGFloat = 0.0
            let startPositiveYCoord = initialTouchYCoord - neutralZoneRange
            let startNegativeYCoord = initialTouchYCoord + neutralZoneRange
            
            if yLocation < startPositiveYCoord {
                if initialTouchYCoord > 3 * viewHeight/10 {
                    accelerationPercentage = (startPositiveYCoord - yLocation) / (startPositiveYCoord)
                } else {
                    if !hasVibrated {
                        // Vibrate to notify touch out of range
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        hasVibrated = true
                    }
                }
            } else if yLocation > startNegativeYCoord {
                accelerationPercentage = -((yLocation - startNegativeYCoord) / (viewHeight - startNegativeYCoord))
                if initialTouchYCoord > 7 * (viewHeight/10) {
                    accelerationPercentage *= 0.5
                }
            }
            var accelerationPercentageInt = Int(accelerationPercentage * 100)
            
            // Temporary fix for bug on IOS device (not simulator), goes up to 104% and down to only -97%
            if accelerationPercentageInt > 100 {
                accelerationPercentageInt = 100
            }
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

