//
//  Dish.swift
//  PickADish
//
//  Modernized architecture - 2024
//

import Foundation

/// Represents a dish with its name and category
struct Dish: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let name: String
    let category: Category

    init(id: UUID = UUID(), name: String, category: Category) {
        self.id = id
        self.name = name
        self.category = category
    }

    /// Generates a search URL for this dish on the specified recipe source
    func searchURL(on source: RecipeSource) -> URL? {
        source.searchURL(for: name)
    }
}

/// Extension for creating dishes from the static data
extension Dish {
    /// Creates an array of dishes from dish names for a given category
    static func dishes(from names: [String], category: Category) -> [Dish] {
        names.filter { !$0.isEmpty }.map { Dish(name: $0, category: category) }
    }
}
