//
//  AppDelegate.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window: UIWindow!
    let appRouter: MainRouter!
    
    override init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.appRouter = MainRouter()
        
        super.init()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        self.window.rootViewController = self.appRouter.getRootViewController()
        self.window.makeKeyAndVisible()
        
        return true
    }
}
