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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        rightSwipe.direction = .Right
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPress(sender: UIButton) {
        label.text = "new text"
    }

    @IBAction func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .Up) {
            label.text = "up"
        }
        else if (sender.direction == .Down) {
            label.text = "down"
        } else if (sender.direction == .Left){}
        else if (sender.direction == .Right){}
    }
}

