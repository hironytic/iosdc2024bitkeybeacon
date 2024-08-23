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
            label.text = "start monitoring"
            manager.startMonitoring(for: beaconRegion)
        } else {
            label.text = "stop monitoring"
            manager.stopMonitoring(for: beaconRegion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        guard let beaconRegion = region as? CLBeaconRegion else { return }
        switch state {
        case .inside: // 領域内
            label.text = "inside"
            manager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        case .outside: // 領域外
            label.text = "outside"
            manager.stopRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        case .unknown: // 不明
            label.text = "unknown"
            manager.stopRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        switch beacons.first!.proximity {
        case .far:
            label.text = "inside far"
        case .immediate:
            label.text = "inside immediate"
        case .near:
            label.text = "inside near"
        case .unknown:
            label.text = "inside unknown"
        @unknown default: return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        label.text = ""
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}
