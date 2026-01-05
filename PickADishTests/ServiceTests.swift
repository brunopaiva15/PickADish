//
//  ServiceTests.swift
//  PickADishTests
//
//  Unit tests for the service layer
//

import XCTest
@testable import PickADish

@MainActor
final class DishServiceTests: XCTestCase {

    var sut: DishService!

    override func setUp() async throws {
        sut = DishService()
    }

    override func tearDown() async throws {
        sut = nil
    }

    // MARK: - Initial State Tests

    func testInitialState() {
        XCTAssertNil(sut.currentDish)
        XCTAssertTrue(sut.dishHistory.isEmpty)
        XCTAssertFalse(sut.canGoBack)
    }

    // MARK: - Generate Dish Tests

    func testGenerateNewDish() {
        let dish = sut.generateNewDish(for: .plats)

        XCTAssertNotNil(dish)
        XCTAssertEqual(dish?.category, .plats)
        XCTAssertEqual(sut.currentDish, dish)
    }

    func testGenerateMultipleDishes() {
        _ = sut.generateNewDish(for: .plats)
        _ = sut.generateNewDish(for: .plats)
        _ = sut.generateNewDish(for: .plats)

        XCTAssertTrue(sut.canGoBack)
        XCTAssertEqual(sut.dishHistory.count, 2) // First dish + second dish (before third)
    }

    // MARK: - Go Back Tests

    func testGoBackWithNoHistory() {
        let result = sut.goBack()
        XCTAssertNil(result)
    }

    func testGoBackWithHistory() {
        let first = sut.generateNewDish(for: .entrees)
        let _ = sut.generateNewDish(for: .entrees)

        let result = sut.goBack()

        XCTAssertNotNil(result)
        XCTAssertEqual(sut.currentDish?.name, first?.name)
    }

    func testCanGoBackUpdates() {
        XCTAssertFalse(sut.canGoBack)

        _ = sut.generateNewDish(for: .plats)
        XCTAssertFalse(sut.canGoBack) // Still false with only one dish

        _ = sut.generateNewDish(for: .plats)
        XCTAssertTrue(sut.canGoBack) // True with two dishes
    }

    // MARK: - Clear History Tests

    func testClearHistory() {
        _ = sut.generateNewDish(for: .plats)
        _ = sut.generateNewDish(for: .plats)

        sut.clearHistory()

        XCTAssertNil(sut.currentDish)
        XCTAssertTrue(sut.dishHistory.isEmpty)
        XCTAssertFalse(sut.canGoBack)
    }

    // MARK: - Set Current Dish Tests

    func testSetCurrentDish() {
        let dish = Dish(name: "Test Dish", category: .desserts)
        sut.setCurrentDish(dish)

        XCTAssertEqual(sut.currentDish, dish)
    }

    func testSetCurrentDishAddsToHistory() {
        let first = Dish(name: "First", category: .plats)
        let second = Dish(name: "Second", category: .plats)

        sut.setCurrentDish(first)
        sut.setCurrentDish(second)

        XCTAssertEqual(sut.currentDish, second)
        XCTAssertTrue(sut.canGoBack)
    }

    // MARK: - Statistics Tests

    func testDishCount() {
        let count = sut.dishCount(for: .plats)
        XCTAssertGreaterThan(count, 0)
        XCTAssertEqual(count, DishData.plats.count)
    }

    func testTotalDishCount() {
        XCTAssertEqual(sut.totalDishCount, DishData.totalCount)
    }
}

@MainActor
final class FavoritesManagerTests: XCTestCase {

    var sut: FavoritesManager!

    override func setUp() async throws {
        // Clear any existing favorites for testing
        UserDefaults.standard.removeObject(forKey: "PAD_FAVOURITES_V2")
        UserDefaults.standard.removeObject(forKey: "PAD_FAVOURITES")
        sut = FavoritesManager()
    }

    override func tearDown() async throws {
        UserDefaults.standard.removeObject(forKey: "PAD_FAVOURITES_V2")
        sut = nil
    }

    // MARK: - Add Favorite Tests

    func testAddToFavorites() {
        let dish = Dish(name: "Test Dish", category: .plats)

        let result = sut.addToFavorites(dish)

        XCTAssertTrue(result)
        XCTAssertTrue(sut.isFavorite(dish))
        XCTAssertEqual(sut.favorites.count, 1)
    }

    func testAddDuplicateFavorite() {
        let dish = Dish(name: "Test Dish", category: .plats)

        _ = sut.addToFavorites(dish)
        let result = sut.addToFavorites(dish)

        XCTAssertFalse(result)
        XCTAssertEqual(sut.favorites.count, 1)
    }

    // MARK: - Remove Favorite Tests

    func testRemoveFromFavorites() {
        let dish = Dish(name: "Test Dish", category: .plats)
        _ = sut.addToFavorites(dish)

        sut.removeFromFavorites(dish)

        XCTAssertFalse(sut.isFavorite(dish))
        XCTAssertTrue(sut.favorites.isEmpty)
    }

    func testRemoveFromFavoritesAtIndex() {
        let dish1 = Dish(name: "Dish 1", category: .plats)
        let dish2 = Dish(name: "Dish 2", category: .plats)
        _ = sut.addToFavorites(dish1)
        _ = sut.addToFavorites(dish2)

        sut.removeFromFavorites(at: 0)

        XCTAssertEqual(sut.favorites.count, 1)
        XCTAssertFalse(sut.isFavorite(dish1))
        XCTAssertTrue(sut.isFavorite(dish2))
    }

    // MARK: - Toggle Favorite Tests

    func testToggleFavoriteAdd() {
        let dish = Dish(name: "Test Dish", category: .plats)

        let result = sut.toggleFavorite(dish)

        XCTAssertTrue(result)
        XCTAssertTrue(sut.isFavorite(dish))
    }

    func testToggleFavoriteRemove() {
        let dish = Dish(name: "Test Dish", category: .plats)
        _ = sut.addToFavorites(dish)

        let result = sut.toggleFavorite(dish)

        XCTAssertFalse(result)
        XCTAssertFalse(sut.isFavorite(dish))
    }

    // MARK: - Clear All Tests

    func testClearAllFavorites() {
        let dish1 = Dish(name: "Dish 1", category: .plats)
        let dish2 = Dish(name: "Dish 2", category: .desserts)
        _ = sut.addToFavorites(dish1)
        _ = sut.addToFavorites(dish2)

        sut.clearAllFavorites()

        XCTAssertTrue(sut.favorites.isEmpty)
    }

    // MARK: - Is Favorite Tests

    func testIsFavoriteByNameAndCategory() {
        let dish1 = Dish(name: "Same Name", category: .plats)
        let dish2 = Dish(name: "Same Name", category: .desserts) // Different category

        _ = sut.addToFavorites(dish1)

        XCTAssertTrue(sut.isFavorite(dish1))
        XCTAssertFalse(sut.isFavorite(dish2)) // Same name but different category
    }
}
