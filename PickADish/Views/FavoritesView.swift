//
//  FavoritesView.swift
//  PickADish
//
//  View showing the list of favorite dishes
//

import SwiftUI

struct FavoritesView: View {

    // MARK: - Environment

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    // MARK: - ViewModel

    @StateObject var viewModel: FavoritesViewModel

    // MARK: - State

    @State private var selectedDish: Dish?
    @State private var showSafari = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isEmpty {
                    emptyStateView
                } else {
                    favoritesList
                }
            }
            .navigationTitle("Favoris")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showSafari) {
                if let dish = selectedDish,
                   let url = viewModel.recipeURL(for: dish) {
                    SafariView(url: url)
                        .ignoresSafeArea()
                }
            }
        }
    }

    // MARK: - Subviews

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.slash")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text("Pas de favoris")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Ajoutez des plats à vos favoris\npour les retrouver ici")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var favoritesList: some View {
        List {
            Section {
                ForEach(viewModel.favorites) { dish in
                    FavoriteRow(dish: dish) {
                        openRecipe(for: dish)
                    }
                }
                .onDelete(perform: viewModel.removeFavorites)
            } header: {
                Text("Plats favoris")
            }
        }
    }

    // MARK: - Methods

    private func openRecipe(for dish: Dish) {
        guard let url = viewModel.recipeURL(for: dish) else { return }

        if viewModel.shouldOpenInApp {
            selectedDish = dish
            showSafari = true
        } else {
            openURL(url)
        }
    }
}

// MARK: - Favorite Row

struct FavoriteRow: View {
    let dish: Dish
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: dish.category.symbolName)
                    .foregroundStyle(.secondary)
                    .frame(width: 30)

                VStack(alignment: .leading, spacing: 2) {
                    Text(dish.name)
                        .font(.body)
                        .foregroundStyle(.primary)

                    Text(dish.category.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    FavoritesView(
        viewModel: FavoritesViewModel(
            favoritesManager: FavoritesManager(),
            settings: SettingsManager()
        )
    )
}
