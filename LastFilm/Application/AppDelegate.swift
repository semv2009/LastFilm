//
//  AppDelegate.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let keyWindow = UIWindow(frame: UIScreen.main.bounds)
        window = keyWindow
        window?.rootViewController = UINavigationController(rootViewController: LastFilmViewController(viewModel: LastFilmViewModel()))
        window?.makeKeyAndVisible()
        return true
    }
}

