//
//  AppDelegate.swift
//  DemoAssignmentIA
//
//  Created by IA on 12/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - UIWindow
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupUNUserNotificationCenter()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func setupUNUserNotificationCenter() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
}
//
// MARK: - UNUserNotificationCenterDelegate
//
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // handle the notification tap here
        print("Notification tapped!")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
