//
//  AppDelegate.swift
//  FirePage
//
//  Created by The Ritler on 12/26/16.
//  Copyright © 2016 The Ritler. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var name : String = "No name"
    var level = String()
    var calendar = [String: String]()
    let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 600, width: 600, height: 50))
    func fillNavigation() {
        
    }
    func setX(x: Int) -> Int {
        return Int((Float(x)/414.0)*Float(UIScreen.main.bounds.width))
    }
    func setY(y: Int) -> Int {
        return Int((Float(y)/736.0)*Float(UIScreen.main.bounds.height))
    }
    
    
    
    
    
    
    var colors: [[Float]] = [[0.117647059, 0.588235319, 0.882352948], [0.882352948, 0.882352948, 0.294117659], [0.980392158, 0.0, 0.0], [0.980392158, 0.392156869, 0.980392158], [0.588235319, 0.980392158, 0.588235319], [0.0941176489, 0.470588267, 0.70588237], [0.70588237, 0.70588237, 0.235294133], [0.784313738, 0.0, 0.0], [0.784313738, 0.313725501, 0.784313738], [0.470588267, 0.784313738, 0.470588267], [0.0705882385, 0.352941215, 0.529411793], [0.529411793, 0.529411793, 0.176470608], [0.588235319, 0.0, 0.0], [0.588235319, 0.235294133, 0.588235319], [0.352941215, 0.588235319, 0.352941215], [0.0470588244, 0.235294133, 0.352941185], [0.352941185, 0.352941185, 0.117647067], [0.392156869, 0.0, 0.0], [0.392156869, 0.156862751, 0.392156869], [0.235294133, 0.392156869, 0.235294133], [0.0235294122, 0.117647067, 0.176470593], [0.176470593, 0.176470593, 0.0588235334], [0.196078435, 0.0, 0.0], [0.196078435, 0.0784313753, 0.196078435], [0.117647067, 0.196078435, 0.117647067]]

    var window: UIWindow?
    
    override init () {
        FIRApp.configure()
    }

    //getCalendar(dormname)
    //{
    // go to firebase and read calendar for that dorm
    //}

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
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

