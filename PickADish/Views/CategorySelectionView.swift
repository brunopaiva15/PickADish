//
//  CategorySelectionView.swift
//  PickADish
//
//  Main view for selecting a dish category
//

import SwiftUI

struct CategorySelectionView: View {

    // MARK: - Environment

    @EnvironmentObject private var settings: SettingsManager
    @EnvironmentObject private var dishService: DishService
    @EnvironmentObject private var favoritesManager: FavoritesManager

    // MARK: - State

    @State private var showSettings = false
    @State private var showFavorites = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    // Category buttons
                    ForEach(Category.allCases) { category in
                        NavigationLink {
                            DishGeneratorView(
                                viewModel: DishGeneratorViewModel(
                                    category: category,
                                    dishService: dishService,
                                    favoritesManager: favoritesManager,
                                    settings: settings
                                )
                            )
                        } label: {
                            CategoryButton(category: category)
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .navigationTitle("PickADish")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        settings.triggerLightHaptic()
                        showFavorites = true
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title3)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        settings.triggerLightHaptic()
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(viewModel: SettingsViewModel(settings: settings))
            }
            .sheet(isPresented: $showFavorites) {
                FavoritesView(
                    viewModel: FavoritesViewModel(
                        favoritesManager: favoritesManager,
                        settings: settings
                    )
                )
            }
        }
        .tint(.primary)
    }
}

// MARK: - Category Button

struct CategoryButton: View {
    let category: Category

    var body: some View {
        HStack {
            Image(systemName: category.symbolName)
                .font(.title2)

            Text(category.rawValue)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.primary)
        .foregroundStyle(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

// MARK: - Preview

#Preview {
    CategorySelectionView()
        .environmentObject(SettingsManager())
        .environmentObject(DishService())
        .environmentObject(FavoritesManager())
}
