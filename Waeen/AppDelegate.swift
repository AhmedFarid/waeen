//
//  AppDelegate.swift
//  Waeen
//
//  Created by farid on 3/6/19.
//  Copyright © 2019 farid. All rights reserved.
//
//


import UIKit
import Firebase
import IQKeyboardManagerSwift
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        
        if let user_token = helper.getAPIToken().user_token{
            if helper.getAPIToken().role == "admin" {
            print("user_token\(user_token)")
            let tab = UIStoryboard(name: "Admin", bundle: nil).instantiateInitialViewController()!
            window?.rootViewController = tab
            }else if helper.getAPIToken().role == "parent" {
                print("user_token\(user_token)")
                let tab = UIStoryboard(name: "family", bundle: nil).instantiateInitialViewController()!
                window?.rootViewController = tab
            }else {
                print("user_token\(user_token)")
                let tab = UIStoryboard(name: "famliymember", bundle: nil).instantiateInitialViewController()!
                window?.rootViewController = tab
            }
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,appId: "ffba68ac-bdcc-4dbd-80ce-cd47738d8173",handleNotificationAction: nil,settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
            let userId = OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId
            API_AUTH.notifacation(player_ids: userId ?? "") { (error: Error?, success: Bool, message) in
                if success {
                    print("mmmmmmmmm\(message ?? "") \(userId ?? "")")
                }else{
                }
            }
        })
        //FirebaseApp.configure()
        handleRefreshSentMasseges()
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
    
    var notifatcitonss = [notfications]()
    
    @objc  func handleRefreshSentMasseges() {
        
        API_Masseges.notification{ (error: Error?, notifatcitonss: [notfications]?) in
            if let notifatcitonss = notifatcitonss {
                self.notifatcitonss = notifatcitonss
                print("xxx\(self.notifatcitonss)")
                if let rootViewController = self.window?.rootViewController {
                    print("root")
                    if let tabBarController = rootViewController as? UITabBarController {
                        print("tab")
                        let tabBarItem = tabBarController.tabBar.items![3]
                        tabBarItem.badgeValue = "\(notifatcitonss.count)"
                    }
                }
                    
                }
                
            }
        }
        
    }


