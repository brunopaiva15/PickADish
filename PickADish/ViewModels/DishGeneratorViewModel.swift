//
//  DishGeneratorViewModel.swift
//  PickADish
//
//  ViewModel for the dish generation view
//

import SwiftUI

/// ViewModel that handles dish generation logic
@MainActor
final class DishGeneratorViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var currentDish: Dish?
    @Published var backgroundColor: Color = Color(uiColor: .systemBackground)
    @Published var foregroundColor: Color = .primary
    @Published private(set) var canGoBack = false

    // MARK: - Properties

    let category: Category

    // MARK: - Dependencies

    private let dishService: DishService
    private let favoritesManager: FavoritesManager
    private let settings: SettingsManager

    // MARK: - Initialization

    init(
        category: Category,
        dishService: DishService,
        favoritesManager: FavoritesManager,
        settings: SettingsManager
    ) {
        self.category = category
        self.dishService = dishService
        self.favoritesManager = favoritesManager
        self.settings = settings

        // Initialize colors
        updateColors()
    }

    // MARK: - Public Methods

    /// Generates a new random dish
    func generateNewDish() {
        settings.triggerHaptic(.success)

        if let dish = dishService.generateNewDish(for: category) {
            currentDish = dish
            canGoBack = dishService.canGoBack
            updateColors()
        }
    }

    /// Goes back to the previous dish
    func goBack() {
        settings.triggerLightHaptic()

        if let dish = dishService.goBack() {
            currentDish = dish
            canGoBack = dishService.canGoBack
            if settings.colorsEnabled {
                updateColors()
            }
        }
    }

    /// Checks if the current dish is a favorite
    func isCurrentDishFavorite() -> Bool {
        guard let dish = currentDish else { return false }
        return favoritesManager.isFavorite(dish)
    }

    /// Toggles favorite status for current dish
    func toggleFavorite() -> Bool {
        guard let dish = currentDish else { return false }
        settings.triggerLightHaptic()
        return favoritesManager.toggleFavorite(dish)
    }

    /// Returns the recipe URL for the current dish
    func recipeURL() -> URL? {
        currentDish?.searchURL(on: settings.recipeSource)
    }

    /// Whether to open links in-app
    var shouldOpenInApp: Bool {
        settings.openLinksInApp
    }

    /// Sharing text for the current dish
    var sharingText: String {
        guard let dish = currentDish,
              let url = recipeURL() else {
            return ""
        }
        return "Découvre ce plat trouvé sur PickADish ! \(url.absoluteString)"
    }

    /// Handles swipe right gesture
    func handleSwipeRight() {
        guard settings.swipeEnabled else { return }
        generateNewDish()
    }

    /// Handles swipe left gesture
    func handleSwipeLeft() {
        guard settings.swipeEnabled else { return }
        goBack()
    }

    // MARK: - Private Methods

    private func updateColors() {
        if settings.colorsEnabled {
            if settings.lighterColorsEnabled {
                backgroundColor = Color(PastelColors.random())
            } else {
                backgroundColor = Color.random()
            }
            foregroundColor = backgroundColor.contrastingColor()
        } else {
            backgroundColor = Color(uiColor: .systemBackground)
            foregroundColor = .primary
        }
    }
}
