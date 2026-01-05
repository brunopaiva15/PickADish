//
//  DishTests.swift
//  PickADishTests
//
//  Unit tests for the Dish model and related types
//

import XCTest
@testable import PickADish

final class DishTests: XCTestCase {

    // MARK: - Category Tests

    func testCategoryRawValues() {
        XCTAssertEqual(Category.entrees.rawValue, "Entrées")
        XCTAssertEqual(Category.plats.rawValue, "Plats")
        XCTAssertEqual(Category.desserts.rawValue, "Desserts")
        XCTAssertEqual(Category.boissons.rawValue, "Boissons")
    }

    func testCategoryGenerateButtonTitles() {
        XCTAssertTrue(Category.entrees.generateButtonTitle.contains("entrée"))
        XCTAssertTrue(Category.plats.generateButtonTitle.contains("plat"))
        XCTAssertTrue(Category.desserts.generateButtonTitle.contains("dessert"))
        XCTAssertTrue(Category.boissons.generateButtonTitle.contains("boisson"))
    }

    func testCategorySymbolNames() {
        // Verify each category has a symbol name
        for category in Category.allCases {
            XCTAssertFalse(category.symbolName.isEmpty)
        }
    }

    func testCategoryAllCases() {
        XCTAssertEqual(Category.allCases.count, 4)
    }

    // MARK: - RecipeSource Tests

    func testRecipeSourceRawValues() {
        XCTAssertEqual(RecipeSource.marmiton.rawValue, "Marmiton")
        XCTAssertEqual(RecipeSource.g750.rawValue, "750g")
        XCTAssertEqual(RecipeSource.cuisineAZ.rawValue, "Cuisine AZ")
        XCTAssertEqual(RecipeSource.journalDesFemmes.rawValue, "Journal des femmes")
    }

    func testRecipeSourceURLPrefixes() {
        XCTAssertTrue(RecipeSource.marmiton.searchURLPrefix.contains("marmiton.org"))
        XCTAssertTrue(RecipeSource.g750.searchURLPrefix.contains("750g.com"))
        XCTAssertTrue(RecipeSource.cuisineAZ.searchURLPrefix.contains("cuisineaz.com"))
        XCTAssertTrue(RecipeSource.journalDesFemmes.searchURLPrefix.contains("journaldesfemmes.fr"))
    }

    func testMarmitonURLFormatting() {
        // Marmiton uses hyphens instead of spaces
        let formatted = RecipeSource.marmiton.formatDishNameForURL("Boeuf bourguignon")
        XCTAssertTrue(formatted.contains("-"))
        XCTAssertFalse(formatted.contains(" "))
    }

    func testOtherSourcesURLFormatting() {
        // Other sources use %20 for spaces
        let formatted = RecipeSource.g750.formatDishNameForURL("Boeuf bourguignon")
        XCTAssertTrue(formatted.contains("%20"))
        XCTAssertFalse(formatted.contains(" "))
    }

    func testAccentRemoval() {
        let formatted = RecipeSource.marmiton.formatDishNameForURL("Crème brûlée")
        XCTAssertFalse(formatted.contains("è"))
        XCTAssertFalse(formatted.contains("û"))
        XCTAssertFalse(formatted.contains("é"))
    }

    func testSpaceCakeEasterEgg() {
        let url = RecipeSource.marmiton.searchURL(for: "Space cake")
        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("google.com"))
    }

    func testSearchURLGeneration() {
        let url = RecipeSource.marmiton.searchURL(for: "Pizza")
        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("marmiton.org"))
        XCTAssertTrue(url!.absoluteString.contains("Pizza"))
    }

    // MARK: - Dish Tests

    func testDishCreation() {
        let dish = Dish(name: "Test Dish", category: .plats)
        XCTAssertEqual(dish.name, "Test Dish")
        XCTAssertEqual(dish.category, .plats)
        XCTAssertNotNil(dish.id)
    }

    func testDishEquality() {
        let id = UUID()
        let dish1 = Dish(id: id, name: "Test", category: .plats)
        let dish2 = Dish(id: id, name: "Test", category: .plats)
        XCTAssertEqual(dish1, dish2)
    }

    func testDishSearchURL() {
        let dish = Dish(name: "Ratatouille", category: .plats)
        let url = dish.searchURL(on: .marmiton)
        XCTAssertNotNil(url)
        XCTAssertTrue(url!.absoluteString.contains("Ratatouille"))
    }

    func testDishesFromNames() {
        let names = ["Dish1", "Dish2", "Dish3"]
        let dishes = Dish.dishes(from: names, category: .entrees)
        XCTAssertEqual(dishes.count, 3)
        XCTAssertEqual(dishes[0].name, "Dish1")
        XCTAssertEqual(dishes[0].category, .entrees)
    }

    func testDishesFromNamesFiltersEmpty() {
        let names = ["Dish1", "", "Dish3", ""]
        let dishes = Dish.dishes(from: names, category: .desserts)
        XCTAssertEqual(dishes.count, 2)
    }

    // MARK: - DishData Tests

    func testDishDataNotEmpty() {
        XCTAssertFalse(DishData.entrees.isEmpty)
        XCTAssertFalse(DishData.plats.isEmpty)
        XCTAssertFalse(DishData.desserts.isEmpty)
        XCTAssertFalse(DishData.boissons.isEmpty)
    }

    func testDishDataForCategory() {
        let entreesDishes = DishData.dishes(for: .entrees)
        XCTAssertEqual(entreesDishes.count, DishData.entrees.count)

        for dish in entreesDishes {
            XCTAssertEqual(dish.category, .entrees)
        }
    }

    func testRandomDish() {
        let dish = DishData.randomDish(for: .plats)
        XCTAssertNotNil(dish)
        XCTAssertEqual(dish!.category, .plats)
    }

    func testTotalCount() {
        let expected = DishData.entrees.count + DishData.plats.count +
                       DishData.desserts.count + DishData.boissons.count
        XCTAssertEqual(DishData.totalCount, expected)
        XCTAssertGreaterThan(DishData.totalCount, 500) // We know we have 500+ dishes
    }
}
