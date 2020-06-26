//
//  AppDelegate.swift
//  PickAFood
//
//  Created by Bruno Vergasta Paiva on 08.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Si l'application n'a jamais été lancée, initialiser les réglages
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore
        {
            SettingsBundleHelper.SetTaptic(yesorno: true)
            SettingsBundleHelper.SetColors(yesorno: true)
            SettingsBundleHelper.SetLighterColors(yesorno: true)
            SettingsBundleHelper.SetShowPopupFirstTime(yesorno: true)
            SettingsBundleHelper.SetOpenLinkInApp(yesorno: true)
            SettingsBundleHelper.SetSlide(yesorno: false)
            SettingsBundleHelper.SetSource(source: "Marmiton")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        // 3D Touch
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
                // Faire une action...
        }
        
        return true
    }
}
