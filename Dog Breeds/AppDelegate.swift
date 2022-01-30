//
//  AppDelegate.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = TabBarController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    static var shared: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not retrieve appDelegate instance")
        }
        
        return appDelegate
    }
}
