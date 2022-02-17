//
//  ViewController.swift
//  iBeaconAdvertiser
//
//  Created by TY Tandon on 09/02/22.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    @IBOutlet weak var beaconState: UILabel!
    var peripheralManager:CBPeripheralManager?
    
    @IBOutlet weak var uuidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func advertiseBeacon(_ sender: Any) {
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func createBeaconRegion() -> CLBeaconRegion? {
        let major : CLBeaconMajorValue = 100
        let minor : CLBeaconMinorValue = 1
        let beaconID = "com.beacon.myDeviceRegion"
        
        return CLBeaconRegion(uuid: UUID(uuidString: "<Enter your UUID here>")!, major: major, minor: minor, identifier: beaconID)
    }
    
    //MARK: CBPeripheralManagerDelegate methods
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        beaconState.text = "Beacon state is " + String(peripheral.state.rawValue)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        beaconState.text = String(peripheral.state.rawValue)
        if peripheral.state == CBManagerState.poweredOn {
            if let region = createBeaconRegion() {
                let peripheralData = region.peripheralData(withMeasuredPower: nil)
                peripheralManager?.startAdvertising(((peripheralData as NSDictionary) as! [String : Any]))
            }
        }
    }
}

