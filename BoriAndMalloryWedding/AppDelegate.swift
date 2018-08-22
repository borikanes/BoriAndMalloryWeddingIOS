//
//  AppDelegate.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 4/15/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let tabVC = self.window?.rootViewController as? UITabBarController {
            if tabVC.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular &&
                tabVC.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
                if let helveticaFont = UIFont(name: "Helvetica Neue", size: 20) {
                    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: helveticaFont], for: UIControlState.normal)
                }
            }
        }
        
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            guard error == nil else {
                print("Something went wrong with requesting notification permission: \(error!)")
                return
            }
            
            if !granted {
                print("Was not granted permission...")
            } else {
                self.center.delegate = self
                let notifcationHelper = NotificationHelper()
                notifcationHelper.configureNotifications(onCompletion: {
                    print("Notifications successfully created...")
                }, onError: { (error) in
                    print("Error creating notifications: \(error)")
                })
            }
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
//        NotificationCenter.default.removeObserver(someObserver)
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // This allows notifications to show up even when app is in foreground...
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let tabBarController = self.window?.rootViewController as? UITabBarController {
            // When notification is selected, move to Schedule VC
            tabBarController.selectedIndex = 1
        }
        
        completionHandler()
    }
}
