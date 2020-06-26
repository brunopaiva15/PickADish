//
//  ActualFood.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 12.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

// CLASSE QUI S'OCCUPE DES DONNEES DU PLAT SELECTIONNE

import Foundation

class ActualFood {
    // Variables qui contiendront le nom, l'URL et le type du plat
    static var foodName = ""
    static var foodUrl = ""
    static var foodType = ""
    
    // Fonctions qui s'occupent de mettre à jour une donnée
    static func setFoodName(foodName: String) {
        ActualFood.foodName = foodName
    }
    
    static func setFoodUrl(foodUrl: String) {
        ActualFood.foodUrl = foodUrl
    }
    
    static func setFoodType(foodType: String) {
        ActualFood.foodType = foodType
    }
    
    // Fonctions qui s'occupent de récupérer la valeur d'une donnée
    static func getFoodName() -> String {
        return foodName
    }
    
    static func getFoodUrl() -> String {
        return foodUrl
    }
    
    static func getFoodType() -> String {
        return foodType
    }
}
