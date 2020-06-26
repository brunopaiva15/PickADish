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
        
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
                notifyUser(message: shortcutItem.type)
        }
        
        
        return true
    }
    
    func notifyUser(message: String) {

        let alertController = UIAlertController(title: "Quick Action",
                        message: message,
                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                        style: .default,
                        handler: nil)

        alertController.addAction(okAction)

        window!.rootViewController?.present(alertController,
                animated: true, completion: nil)
    }
}
