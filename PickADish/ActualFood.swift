//
//  ActualFood.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 12.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import Foundation

class ActualFood {
    static var foodName = ""
    static var foodUrl = ""
    static var foodType = ""
    
    static func setFoodName(foodName: String) {
        ActualFood.foodName = foodName
    }
    
    static func setFoodUrl(foodUrl: String) {
        ActualFood.foodUrl = foodUrl
    }
    
    static func setFoodType(foodType: String) {
        ActualFood.foodType = foodType
    }
    
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
