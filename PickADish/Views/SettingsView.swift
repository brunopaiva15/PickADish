//
//  SettingsView.swift
//  PickADish
//
//  Settings view for the app
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Environment

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    // MARK: - ViewModel

    @StateObject var viewModel: SettingsViewModel

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Form {
                // Appearance section
                Section {
                    Toggle("Couleurs aléatoires", isOn: viewModel.colorsEnabled)

                    Toggle("Couleurs pastel", isOn: viewModel.lighterColorsEnabled)
                        .disabled(!viewModel.settings.colorsEnabled)
                } header: {
                    Label("Apparence", systemImage: "paintbrush.fill")
                }

                // System section
                Section {
                    if viewModel.isHapticAvailable {
                        Toggle("Vibrations", isOn: viewModel.hapticEnabled)
                    } else {
                        HStack {
                            Text("Vibrations")
                            Spacer()
                            Text("Non disponible")
                                .foregroundStyle(.secondary)
                        }
                    }

                    Toggle("Navigation par swipe", isOn: viewModel.swipeEnabled)

                    Toggle("Ouvrir les liens dans l'app", isOn: viewModel.openLinksInApp)
                } header: {
                    Label("Système", systemImage: "gear")
                }

                // Recipe source section
                Section {
                    Picker("Source des recettes", selection: viewModel.recipeSource) {
                        ForEach(RecipeSource.allCases) { source in
                            Text(source.rawValue).tag(source)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Label("Recettes", systemImage: "book.fill")
                }

                // About section
                Section {
                    Button {
                        openURL(viewModel.developerWebsiteURL)
                    } label: {
                        HStack {
                            Text("Site du développeur")
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .foregroundStyle(.primary)

                    Button {
                        openURL(viewModel.privacyPolicyURL)
                    } label: {
                        HStack {
                            Text("Politique de confidentialité")
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .foregroundStyle(.primary)

                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Label("À propos", systemImage: "info.circle.fill")
                }
            }
            .navigationTitle("Réglages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
        }
    }

    // MARK: - Computed Properties

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}

// MARK: - Preview

#Preview {
    SettingsView(viewModel: SettingsViewModel(settings: SettingsManager()))
}
