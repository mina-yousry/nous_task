//
//  AppDelegate.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/13/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: ItemsCoordinator?
    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.navController = UINavigationController()
        coordinator = ItemsCoordinator(window: self.window, rootViewController: self.navController ?? UINavigationController())
        coordinator?.start()
        return true
    }


}

