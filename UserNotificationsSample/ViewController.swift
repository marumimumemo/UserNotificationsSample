//
//  ViewController.swift
//  UserNotificationsSample
//
//  Created by 丸本聡 on 2020/04/05.
//  Copyright © 2020 丸本聡. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        setNotificationWithTarget()
    }
    
    func setNotificationWithTarget() {

        let content = UNMutableNotificationContent()
        content.title = "通知"
        content.body = "近くに来たので挨拶しましょう。"
        content.sound = UNNotificationSound.default
        
        // UNLocationNotificationTrigger 作成
        let coordinate = CLLocationCoordinate2DMake(35.697275, 139.774728)
        let region = CLCircularRegion.init(center: coordinate, radius: 1000.0, identifier: "Headquarter")
        region.notifyOnEntry = true;
        region.notifyOnExit = false;
        let trigger = UNLocationNotificationTrigger.init(region: region, repeats: false)
        
        // id, content, trigger から UNNotificationRequest 作成
        let request = UNNotificationRequest.init(identifier: "LocationNotification", content: content, trigger: trigger)
        
        // UNUserNotificationCenter に request を追加
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}

extension ViewController: CLLocationManagerDelegate {
    // 位置情報へのアクセスへの許可の状態が変化したら呼ばれる
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("location AuthorizationStatus:\(status)")
    }
}
