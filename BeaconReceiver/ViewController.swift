//
//  ViewController.swift
//  BeaconReceiver
//
//  Created by Ryan Jones on 4/19/16.
//  Copyright © 2016 Ryan Jones. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var Found: UILabel!
    @IBOutlet weak var UUID: UILabel!
    @IBOutlet weak var Minor: UILabel!
    @IBOutlet weak var Accuracy: UILabel!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var RSSI: UILabel!
    @IBOutlet var major: UILabel!
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, identifier: "MySmartDoor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.startRangingBeaconsInRegion(region)
        locationManager.requestAlwaysAuthorization()

    }

 
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        print(beacons[0])
        updateInterface()
        
    }
    
    func updateInterface(){
        //pass beacon in here and update everything
        self.major.text = "0"
    }
}

