//
//  ViewController.swift
//  iosdc2024ibeacon
//
//  Created by 一宮浩教 on 2024/08/23.
//

import UIKit
import CoreLocation

let uuid = UUID(uuidString: "41462998-6CEB-4511-9D46-1F7E27AA6572")!
let major: CLBeaconMajorValue = 18
let minor: CLBeaconMinorValue = 5

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var label: UILabel!
    var locationManager: CLLocationManager!
    let beaconRegion = CLBeaconRegion(uuid: uuid, major: major, minor: minor, identifier: "id")

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startMonitoring(for: beaconRegion)
        } else {
            manager.stopMonitoring(for: beaconRegion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside: // 領域内
            label.text = "inside"
        case .outside: // 領域外
            label.text = "outside"
        case .unknown: // 不明
            label.text = "unknown"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        label.text = "initializing"
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}
