//
//  WelcomePopupView.swift
//  PickADish
//
//  Welcome popup shown on first launch
//

import SwiftUI

struct WelcomePopupView: View {

    // MARK: - Environment

    @Environment(\.dismiss) private var dismiss

    // MARK: - Properties

    let onDismiss: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 16) {
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.orange)

                Text("Bienvenue !")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.top, 40)

            // Description
            VStack(alignment: .leading, spacing: 20) {
                FeatureRow(
                    icon: "hand.tap.fill",
                    title: "Générer un plat",
                    description: "Appuyez sur le bouton pour obtenir une idée de plat aléatoire"
                )

                FeatureRow(
                    icon: "text.magnifyingglass",
                    title: "Voir la recette",
                    description: "Cliquez sur le nom du plat pour voir les détails et la recette"
                )

                FeatureRow(
                    icon: "star.fill",
                    title: "Sauvegarder",
                    description: "Ajoutez vos plats préférés aux favoris pour les retrouver facilement"
                )

                FeatureRow(
                    icon: "square.and.arrow.up",
                    title: "Partager",
                    description: "Partagez vos découvertes culinaires avec vos proches"
                )
            }
            .padding(.horizontal)

            Spacer()

            // Dismiss button
            Button {
                onDismiss()
                dismiss()
            } label: {
                Text("C'est parti !")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.orange)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .interactiveDismissDisabled()
    }
}

// MARK: - Feature Row

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.orange)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    WelcomePopupView(onDismiss: {})
}
