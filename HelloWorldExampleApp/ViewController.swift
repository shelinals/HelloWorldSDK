//
//  ViewController.swift
//  HelloWorldExampleApp
//
//  Created by peter.shih on 2019/8/27.
//  Copyright © 2019年 Peteranny. All rights reserved.
//

import UIKit
import HelloWorldSDK
import Pilgrim

class ViewController: UIViewController {
  
  
    @IBOutlet weak var debugMenuBtn: UIButton!
    @IBOutlet weak var testVisitBtn: UIButton!
    @IBOutlet weak var currentLocBtn: UIButton!
    @IBOutlet weak var currentLocLabel: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        
        let label: UILabel = {
            let label = UILabel()
            label.frame.origin = CGPoint(x: 100, y: 100)
            label.text = HelloWorld().hello(to: "World")
            label.textColor = HelloWorld().helloColor
            label.sizeToFit()
            return label
        }()
        
        view.addSubview(label)
    }
  
  
    @IBAction func debugMenuDidTapped(_ sender: Any) {
      PilgrimManager.shared().presentDebugViewController(parentViewController: self)
    }
  
    
    @IBAction func testVisitDidTapped(_ sender: Any) {
      PilgrimManager.shared().visitTester?.fireTestVisit(location: CLLocation(latitude: 1.3492159, longitude: 103.8895157))
    }
  
    @IBAction func currentLocDidTapped(_ sender: Any) {
      PilgrimManager.shared().getCurrentLocation { (currentLocation, error) in
        guard currentLocation != nil else { return self.currentLocLabel.text = "nil" }
        self.currentLocLabel.text = currentLocation?.currentPlace.displayName
      }
    }
  
}
