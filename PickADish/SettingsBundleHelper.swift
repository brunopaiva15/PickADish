//
//  SettingsBundleHelper.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 12.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

// CLASSE QUI S'OCCUPE DES DONNEES DES REGLAGES

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        // Structure qui contient les clés des réglages
        static let Colors = "PAD_COLORS"
        static let Source = "PAD_SOURCE"
        static let FoodType = "PAD_TYPE"
        static let Taptic = "PAD_TAPTIC"
        static let LightColors = "PAD_LIGHTER_COLORS"
        static let ShowPopUpFirstTime = "PAD_SHOW_POPUP_FIRST_TIME"
        static let Favourites = "PAD_FAVOURITES"
        static let Slide = "PAD_SLIDE"
        static let OpenLinkInApp = "PAD_OPENINAPP"
    }
    
    // Fonctions qui s'occupent de mettre à jour un réglage
    class func SetColors(yesorno: Bool) {
        UserDefaults.standard.set(yesorno, forKey: SettingsBundleKeys.Colors)
    }
    
    class func SetSource (source: String) {
        UserDefaults.standard.set(source, forKey: SettingsBundleKeys.Source)
    }
    
    class func SetType (type: String) {
        UserDefaults.standard.set(type, forKey: SettingsBundleKeys.FoodType)
    }
    
    class func SetTaptic (yesorno: Bool) {
        UserDefaults.standard.set(yesorno, forKey: SettingsBundleKeys.Taptic)
    }
    
    class func SetLighterColors(yesorno: Bool) {
        UserDefaults.standard.set(yesorno, forKey: SettingsBundleKeys.LightColors)
    }
    
    class func SetShowPopupFirstTime(yesorno: Bool) {
        UserDefaults.standard.set(yesorno, forKey: SettingsBundleKeys.ShowPopUpFirstTime)
    }
    
    class func AddDishToFavourites(dish: String) {
        var strings: [String] = UserDefaults.standard.object(forKey: SettingsBundleKeys.Favourites) as? [String] ?? []
        strings.append(dish)
        UserDefaults.standard.set(strings, forKey: SettingsBundleKeys.Favourites)
    }
    
    class func DeleteDishFromFavourites(index: Int) {
        var strings: [String] = UserDefaults.standard.object(forKey: SettingsBundleKeys.Favourites) as? [String] ?? []
        strings.remove(at: index)
        UserDefaults.standard.set(strings, forKey: SettingsBundleKeys.Favourites)
    }
    
    class func SetSlide(yesorno: Bool) {
        UserDefaults.standard.set(yesorno, forKey: SettingsBundleKeys.Slide)
    }
    
    class func SetOpenLinkInApp(yesorno: Bool) {
        UserDefaults.standard.set(yesorno, forKey: SettingsBundleKeys.OpenLinkInApp)
    }
}
