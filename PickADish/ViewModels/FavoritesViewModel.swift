//
//  FavoritesViewModel.swift
//  PickADish
//
//  ViewModel for the favorites view
//

import SwiftUI

/// ViewModel that handles favorites list logic
@MainActor
final class FavoritesViewModel: ObservableObject {

    // MARK: - Dependencies

    private let favoritesManager: FavoritesManager
    private let settings: SettingsManager

    // MARK: - Computed Properties

    var favorites: [Dish] {
        favoritesManager.favorites
    }

    var isEmpty: Bool {
        favorites.isEmpty
    }

    // MARK: - Initialization

    init(favoritesManager: FavoritesManager, settings: SettingsManager) {
        self.favoritesManager = favoritesManager
        self.settings = settings
    }

    // MARK: - Public Methods

    /// Removes a favorite at the specified offsets
    func removeFavorites(at offsets: IndexSet) {
        for index in offsets {
            favoritesManager.removeFromFavorites(at: index)
        }
    }

    /// Returns the recipe URL for a dish
    func recipeURL(for dish: Dish) -> URL? {
        dish.searchURL(on: settings.recipeSource)
    }

    /// Whether to open links in-app
    var shouldOpenInApp: Bool {
        settings.openLinksInApp
    }
}
