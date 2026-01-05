//
//  FavoritesManager.swift
//  PickADish
//
//  Service responsible for managing favorite dishes with persistence
//

import Foundation

/// Manager that handles favorite dishes with UserDefaults persistence
@MainActor
final class FavoritesManager: ObservableObject {

    // MARK: - Constants

    private enum Keys {
        static let favorites = "PAD_FAVOURITES_V2"
    }

    // MARK: - Published Properties

    /// List of favorite dishes
    @Published private(set) var favorites: [Dish] = []

    // MARK: - Initialization

    init() {
        loadFavorites()
    }

    // MARK: - Public Methods

    /// Adds a dish to favorites
    /// - Parameter dish: The dish to add
    /// - Returns: Whether the dish was added (false if already exists)
    @discardableResult
    func addToFavorites(_ dish: Dish) -> Bool {
        guard !isFavorite(dish) else { return false }

        favorites.append(dish)
        saveFavorites()
        return true
    }

    /// Removes a dish from favorites
    /// - Parameter dish: The dish to remove
    func removeFromFavorites(_ dish: Dish) {
        favorites.removeAll { $0.name == dish.name && $0.category == dish.category }
        saveFavorites()
    }

    /// Removes a dish at the specified index
    /// - Parameter index: The index to remove
    func removeFromFavorites(at index: Int) {
        guard favorites.indices.contains(index) else { return }
        favorites.remove(at: index)
        saveFavorites()
    }

    /// Checks if a dish is in favorites
    /// - Parameter dish: The dish to check
    /// - Returns: Whether the dish is a favorite
    func isFavorite(_ dish: Dish) -> Bool {
        favorites.contains { $0.name == dish.name && $0.category == dish.category }
    }

    /// Toggles the favorite status of a dish
    /// - Parameter dish: The dish to toggle
    /// - Returns: Whether the dish is now a favorite
    @discardableResult
    func toggleFavorite(_ dish: Dish) -> Bool {
        if isFavorite(dish) {
            removeFromFavorites(dish)
            return false
        } else {
            addToFavorites(dish)
            return true
        }
    }

    /// Clears all favorites
    func clearAllFavorites() {
        favorites.removeAll()
        saveFavorites()
    }

    // MARK: - Private Methods

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: Keys.favorites)
        }
    }

    private func loadFavorites() {
        // Try to load new format first
        if let data = UserDefaults.standard.data(forKey: Keys.favorites),
           let decoded = try? JSONDecoder().decode([Dish].self, from: data) {
            favorites = decoded
            return
        }

        // Migrate from old format (string array)
        if let oldFavorites = UserDefaults.standard.stringArray(forKey: "PAD_FAVOURITES") {
            // Convert old string favorites to Dish objects (assume they were "plats")
            favorites = oldFavorites.compactMap { name in
                guard !name.isEmpty else { return nil }
                return Dish(name: name, category: .plats)
            }
            saveFavorites()
            // Remove old format
            UserDefaults.standard.removeObject(forKey: "PAD_FAVOURITES")
        }
    }
}
