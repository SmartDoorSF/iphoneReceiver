//
//  ViewController.swift
//  BeaconReceiver
//
//  Created by Ryan Jones on 4/19/16.
//  Copyright © 2016 Ryan Jones. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var Found: UILabel!
    @IBOutlet weak var UUID: UILabel!
    @IBOutlet weak var Major: UILabel!
    @IBOutlet weak var Minor: UILabel!
    @IBOutlet weak var Accuracy: UILabel!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var RSSI: UILabel!
    
    let uuidObj = NSUUID(UUIDString: "66dae67d-22e2-466b-b7d6-7093d52ceeb7")
    
    var region = CLBeaconRegion()
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        region = CLBeaconRegion(proximityUUID: uuidObj!, identifier: "MySmartDoor")
    }

    @IBAction func StartDetecting(sender: AnyObject) {
        self.manager.requestAlwaysAuthorization()
        self.manager.startMonitoringForRegion(self.region)
        self.Found.text = "Starting Monitor"
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        self.Found.text = "Scanning..."
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion) //testing line
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        self.Found.text = "Possible Match"
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        self.Found.text = "Error :("
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
        reset()
    }
    
    func reset(){
        self.Found.text = "No"
        self.UUID.text = "N/A"
        self.Major.text = "N/A"
        self.Minor.text = "N/A"
        self.Accuracy.text = "N/A"
        self.RSSI.text = "N/A"
    }

    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if(beacons.count == 0) { return }
        
        let beacon = beacons.last
        
        if (beacon!.proximity == CLProximity.Unknown) {
            self.Distance.text = "Unknown Proximity"
            reset()
            return
        } else if (beacon!.proximity == CLProximity.Immediate) {
            self.Distance.text = "Immediate"
        } else if (beacon!.proximity == CLProximity.Near) {
            self.Distance.text = "Near"
            //reset()
        } else if (beacon!.proximity == CLProximity.Far) {
            self.Distance.text = "Far"
        }
        self.Found.text = "Yes!"
        self.UUID.text = beacon!.proximityUUID.UUIDString
        self.Major.text = "\(beacon!.major)"
        self.Minor.text = "\(beacon!.minor)"
        self.Accuracy.text = "\(beacon!.accuracy)"
        self.RSSI.text = "\(beacon!.rssi)"
    }
}

