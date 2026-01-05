//
//  Category.swift
//  PickADish
//
//  Modernized architecture - 2024
//

import Foundation

/// Represents the different dish categories available in the app
enum Category: String, CaseIterable, Codable, Identifiable {
    case entrees = "Entrées"
    case plats = "Plats"
    case desserts = "Desserts"
    case boissons = "Boissons"

    var id: String { rawValue }

    /// The button label for generating a dish of this category
    var generateButtonTitle: String {
        switch self {
        case .entrees: return "Je veux une entrée !"
        case .plats: return "Je veux un plat !"
        case .desserts: return "Je veux un dessert !"
        case .boissons: return "Je veux une boisson !"
        }
    }

    /// SF Symbol name for this category
    var symbolName: String {
        switch self {
        case .entrees: return "leaf.fill"
        case .plats: return "fork.knife"
        case .desserts: return "birthday.cake.fill"
        case .boissons: return "cup.and.saucer.fill"
        }
    }
}
