//
//  AppDelegate.swift
//  HelloWorldExampleApp
//
//  Created by peter.shih on 2019/8/27.
//  Copyright © 2019年 Peteranny. All rights reserved.
//

import UIKit
import Pilgrim

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
  var locationManager: CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
        // Setup core location
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        // Setup Pilgrim
        PilgrimManager.shared().isDebugLogsEnabled = true
        PilgrimManager.shared().shouldDisableAdIdentitySharing = true
        PilgrimManager.shared().configure(withConsumerKey: "SJZHJCTYCTJYUVTI3N1UZ5PUXQLAF3O5Z354YUCKDZ5NNMRL", secret: "U31H2OLN52RIL3125MAIINGI3KWMTEYYOF5IP2YSXKKBI0A4", delegate: self, completion: nil)
        PilgrimManager.shared().userInfo.setUserId("shelina")
      
        return true
    }
  
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .authorizedWhenInUse:
          manager.requestAlwaysAuthorization()
        case .authorizedAlways:
          print("Hello Start")
          PilgrimManager.shared().start()
        default:
          break
        }
      }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate : PilgrimManagerDelegate {
  // Primary visit handler:
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handle visit: Visit) {
    // Process the visit however you'd like:
    print("\(visit.hasDeparted ? "Departure from" : "Arrival at") \(visit.venue != nil ? visit.venue!.name : "Unknown venue."). Added a Pilgrim visit at: \(visit.displayName)")
  }

  // Optional: If visit occurred without network connectivity
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handleBackfill visit: Pilgrim.Visit) {
    // Process the visit however you'd like:
    print("Backfill \(visit.hasDeparted ? "departure from" : "arrival at") \(visit.venue != nil ? visit.venue!.name : "Unknown venue."). Added a Pilgrim backfill visit at: \(visit.displayName)")
  }

  // Optional: If visit occurred by triggering a geofence
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handle geofenceEvents: [GeofenceEvent]) {
    // Process the geofence events however you'd like. Here we loop through the potentially multiple geofence events and handle them individually:
    geofenceEvents.forEach { geofenceEvent in
      print(geofenceEvent)
    }
  }
}

