//
//  AppDelegate.swift
//  Easy Tor
//
//  Created by Gilad Lekner on 20/12/2017.
//  Copyright © 2017 Gilad Lekner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref: DatabaseReference! = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        if Auth.auth().currentUser != nil {
            ref.child("users").child("business").observe(DataEventType.value, with: { (snapshot) in
                if snapshot.hasChild((Auth.auth().currentUser?.uid)!)
                {
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let loginVC=storyboard.instantiateViewController(withIdentifier: "businessTabVC") as! UITabBarController
                    self.window?.rootViewController=loginVC
                }
                else
                {
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let loginVC=storyboard.instantiateViewController(withIdentifier: "ClientTabVC") as! UITabBarController
                    self.window?.rootViewController=loginVC
                }
            })
        }
        else{
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let loginVC=storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        self.window?.rootViewController=loginVC
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
