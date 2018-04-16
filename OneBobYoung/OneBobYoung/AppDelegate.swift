//
//  AppDelegate.swift
//  OneBobYoung
//
//  Created by Hyowon Choi on 2018. 2. 18..
//  Copyright © 2018년 Hyowon Choi. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let hasLaunchedKey = "HasLaunched"
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: hasLaunchedKey) {
            if let path = Bundle.main.path(forResource: "sentence", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String:Any]] {
                        
                        let realm = try! Realm()
                        for item in jsonResult {
                            if let sentence = Mapper<Sentence>().map(JSON: item) {
                                sentence.id = sentence.incrementID()
                                try! realm.write {
                                    realm.add(sentence)
                                }
                            }
                        }
                    }
                } catch {
                }
            }
            
            defaults.set(true, forKey: hasLaunchedKey)
        }
        
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
