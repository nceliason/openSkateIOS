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
    var yLocation: CGFloat = 0.0
    var accelerationPercentage: CGFloat = 0.0
    var startPositiveYCoord: CGFloat = 0.0
    var startNegativeYCoord: CGFloat = 0.0
    var viewHeight: CGFloat = 0.0
    var hasVibrated = false  // so out of range vibration only occurs once
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeight = self.view.frame.size.height
    }

    @IBAction func panAction(sender: UIPanGestureRecognizer) {
        if sender.state == .Began {
            setInitialYCoord(sender)
        } else if sender.state == .Ended {
            resetAccelLabelAndVibration()
        } else {
            calculateAccelerationAndUpdateAccelLabel(sender)
        }
    }
    
    private func setInitialYCoord(sender: UIPanGestureRecognizer) {
        initialTouchYCoord = sender.locationInView(self.view).y
    }
    
    private func resetAccelLabelAndVibration() {
        label.text = "Accel: 0%"
        hasVibrated = false
    }
    
    private func calculateAccelerationAndUpdateAccelLabel(sender: UIPanGestureRecognizer) {
        initializeVariables(sender)
        if isUpswipe() {
            accelerate()
        } else if isDownswipe() {
            decelerate()
        }
        setAccelerationLabel()
    }
    
    private func initializeVariables(sender: UIPanGestureRecognizer) {
        yLocation = sender.locationInView(self.view).y
        accelerationPercentage = 0.0
        startPositiveYCoord = initialTouchYCoord - neutralZoneRange
        startNegativeYCoord = initialTouchYCoord + neutralZoneRange
    }
    
    private func accelerate() {
        if initialTouchInTop30PercentOfScreen() {
            vibrate()
        } else {
            accelerationPercentage = (startPositiveYCoord - yLocation) / (startPositiveYCoord)
        }
    }
    
    private func vibrate() {
        // Vibrate to notify touch out of range
        if !hasVibrated {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            hasVibrated = true
        }
    }
    
    private func decelerate() {
        accelerationPercentage = -((yLocation - startNegativeYCoord) / (viewHeight - startNegativeYCoord))
        if initialTouchInBottom30PercentOfScreen() {
            accelerationPercentage *= 0.5
        }
    }
    
    private func setAccelerationLabel() {
        var accelerationPercentageInt = Int(accelerationPercentage * 100)
        // Temporary fix for bug on IOS device (not simulator), goes up to 104% and down to only -97%
        if accelerationPercentageInt > 100 {
            accelerationPercentageInt = 100
        }
        label.text = "Accel: \(String(accelerationPercentageInt))%"
    }
    
    private func isUpswipe() -> Bool {
        return yLocation < startPositiveYCoord
    }
    
    private func isDownswipe() -> Bool {
        return yLocation > startNegativeYCoord
    }
    
    private func initialTouchInTop30PercentOfScreen() -> Bool {
        return initialTouchYCoord < 3 * viewHeight/10
    }
    
    private func initialTouchInBottom30PercentOfScreen() -> Bool {
        return initialTouchYCoord > 7 * (viewHeight/10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPress(sender: UIButton) {
        label.text = "Scanning"
        //scan()
    }
}

