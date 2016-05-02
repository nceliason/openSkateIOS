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
    var initialY: CGFloat = 0.0
    var initialYToTop = 0
    var initialYToBottom = 0
    let neutralZoneRange = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func panAction(sender: UIPanGestureRecognizer) {
        if sender.state == .Began {
            initialY = sender.locationInView(self.view).y
            print("initialY is \(initialY)")
        } else if sender.state == .Ended {
            label.text = "Accel: 0%"
        } else {
            let viewHeight = self.view.frame.size.height
            let yLocation = sender.locationInView(self.view).y
            let percentage: CGFloat
            if yLocation < initialY {
                percentage = (initialY - sender.locationInView(self.view).y) / initialY
            } else {
                percentage = 0
            }
            let intPercentage = Int(percentage * 100)
            label.text = "Accel: \(String(intPercentage))%"
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

