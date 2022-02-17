//
//  ViewController.swift
//  iBeaconListener
//
//  Created by TY Tandon on 10/02/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    @IBOutlet weak var stateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
        stateLabel.text = error.localizedDescription
    }
      
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
        stateLabel.text = error.localizedDescription
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        stateLabel.text = "beacon found?"
        for beacon in beacons {
            print("beacon found \(beacon.uuid.uuidString)")
            stateLabel.text = "beacon found \(beacon.uuid.uuidString)"
        }
    }
    
    @IBAction func startMonitoring(_ sender: Any) {
        let region = beaconRegion()
        locationManager.startMonitoring(for: region)
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: region.uuid))
    }
    
    @IBAction func stopMonitoring(_ sender: Any) {
        let region = beaconRegion()
        locationManager.stopMonitoring(for: region)
        locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: region.uuid))
    }
    
    func beaconRegion() -> CLBeaconRegion {
        let major : CLBeaconMajorValue = 100
        let minor : CLBeaconMinorValue = 1
        let beaconID = "com.beacon.myDeviceRegion"
            
        return CLBeaconRegion(uuid: UUID(uuidString: "<Enter you UUID here>")!, major: major, minor: minor, identifier: beaconID)
    }
}

