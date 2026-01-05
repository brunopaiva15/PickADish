//
//  DishDetailView.swift
//  PickADish
//
//  View showing dish details with actions
//

import SwiftUI
import SafariServices

struct DishDetailView: View {

    // MARK: - Environment

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    // MARK: - Properties

    let dish: Dish
    @State var isFavorite: Bool
    let recipeURL: URL?
    let sharingText: String
    let openInApp: Bool
    let onToggleFavorite: () -> Void

    // MARK: - State

    @State private var showSafari = false
    @State private var showShareSheet = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()

                // Dish name
                VStack(spacing: 12) {
                    Image(systemName: dish.category.symbolName)
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)

                    Text(dish.name)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.6)
                        .padding(.horizontal)

                    Text(dish.category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                // Action buttons
                VStack(spacing: 16) {
                    // Recipe button
                    Button {
                        openRecipe()
                    } label: {
                        Label("Voir la recette", systemImage: "book.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }

                    HStack(spacing: 16) {
                        // Share button
                        Button {
                            showShareSheet = true
                        } label: {
                            Label("Partager", systemImage: "square.and.arrow.up")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.secondary.opacity(0.2))
                                .foregroundStyle(.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        // Favorite button
                        Button {
                            withAnimation(.spring(response: 0.3)) {
                                isFavorite.toggle()
                            }
                            onToggleFavorite()
                        } label: {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .font(.title2)
                                .frame(width: 50, height: 50)
                                .background(
                                    isFavorite
                                        ? Color.yellow.opacity(0.3)
                                        : Color.secondary.opacity(0.2)
                                )
                                .foregroundStyle(isFavorite ? .yellow : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationTitle("Détails")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showSafari) {
                if let url = recipeURL {
                    SafariView(url: url)
                        .ignoresSafeArea()
                }
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(items: [sharingText])
            }
        }
    }

    // MARK: - Methods

    private func openRecipe() {
        guard let url = recipeURL else { return }

        if openInApp {
            showSafari = true
        } else {
            openURL(url)
        }
    }
}

// MARK: - Safari View

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

// MARK: - Share Sheet

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Preview

#Preview {
    DishDetailView(
        dish: Dish(name: "Boeuf bourguignon", category: .plats),
        isFavorite: false,
        recipeURL: URL(string: "https://www.marmiton.org"),
        sharingText: "Check out this dish!",
        openInApp: true,
        onToggleFavorite: {}
    )
}
