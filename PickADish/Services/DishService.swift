//
//  DishService.swift
//  PickADish
//
//  Service responsible for dish generation and history management
//

import Foundation

/// Service that handles dish generation and maintains history for back navigation
@MainActor
final class DishService: ObservableObject {

    // MARK: - Published Properties

    /// The currently displayed dish
    @Published private(set) var currentDish: Dish?

    /// History of previously generated dishes (for back navigation)
    @Published private(set) var dishHistory: [Dish] = []

    /// Whether the user can go back to a previous dish
    var canGoBack: Bool {
        dishHistory.count > 1
    }

    // MARK: - Public Methods

    /// Generates a new random dish for the specified category
    /// - Parameter category: The category to generate a dish from
    /// - Returns: The newly generated dish, or nil if no dishes available
    @discardableResult
    func generateNewDish(for category: Category) -> Dish? {
        guard let newDish = DishData.randomDish(for: category) else {
            return nil
        }

        // Add current dish to history before changing
        if let current = currentDish {
            dishHistory.append(current)
        }

        currentDish = newDish
        return newDish
    }

    /// Goes back to the previous dish in history
    /// - Returns: The previous dish, or nil if no history
    @discardableResult
    func goBack() -> Dish? {
        guard canGoBack else { return nil }

        // Remove the last dish (current one)
        _ = dishHistory.popLast()

        // Set current to the previous dish
        if let previousDish = dishHistory.last {
            currentDish = previousDish
            return previousDish
        }

        return nil
    }

    /// Clears the dish history and current dish
    func clearHistory() {
        dishHistory.removeAll()
        currentDish = nil
    }

    /// Sets a specific dish as current (used for favorites)
    func setCurrentDish(_ dish: Dish) {
        if let current = currentDish {
            dishHistory.append(current)
        }
        currentDish = dish
    }

    // MARK: - Statistics

    /// Returns the count of dishes for a category
    func dishCount(for category: Category) -> Int {
        DishData.dishes(for: category).count
    }

    /// Returns the total count of all dishes
    var totalDishCount: Int {
        DishData.totalCount
    }
}
