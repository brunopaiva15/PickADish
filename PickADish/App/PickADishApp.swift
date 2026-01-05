//
//  PickADishApp.swift
//  PickADish
//
//  Modern SwiftUI app entry point
//

import SwiftUI

@main
struct PickADishApp: App {

    // MARK: - State Objects

    @StateObject private var settings = SettingsManager()
    @StateObject private var dishService = DishService()
    @StateObject private var favoritesManager = FavoritesManager()

    // MARK: - State

    @State private var showWelcome = false

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            CategorySelectionView()
                .environmentObject(settings)
                .environmentObject(dishService)
                .environmentObject(favoritesManager)
                .onAppear {
                    if settings.showFirstTimePopup {
                        showWelcome = true
                    }
                }
                .sheet(isPresented: $showWelcome) {
                    WelcomePopupView {
                        settings.markFirstTimePopupShown()
                    }
                }
        }
    }
}
