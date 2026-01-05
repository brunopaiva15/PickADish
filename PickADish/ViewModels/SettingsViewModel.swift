//
//  SettingsViewModel.swift
//  PickADish
//
//  ViewModel for the settings view
//

import SwiftUI

/// ViewModel that handles settings logic
@MainActor
final class SettingsViewModel: ObservableObject {

    // MARK: - Dependencies

    let settings: SettingsManager

    // MARK: - Computed Properties

    var colorsEnabled: Binding<Bool> {
        Binding(
            get: { self.settings.colorsEnabled },
            set: { newValue in
                self.settings.colorsEnabled = newValue
                if !newValue {
                    self.settings.lighterColorsEnabled = false
                }
            }
        )
    }

    var lighterColorsEnabled: Binding<Bool> {
        Binding(
            get: { self.settings.lighterColorsEnabled },
            set: { newValue in
                self.settings.lighterColorsEnabled = newValue
                if newValue {
                    self.settings.colorsEnabled = true
                }
            }
        )
    }

    var hapticEnabled: Binding<Bool> {
        Binding(
            get: { self.settings.hapticEnabled },
            set: { self.settings.hapticEnabled = $0 }
        )
    }

    var swipeEnabled: Binding<Bool> {
        Binding(
            get: { self.settings.swipeEnabled },
            set: { self.settings.swipeEnabled = $0 }
        )
    }

    var openLinksInApp: Binding<Bool> {
        Binding(
            get: { self.settings.openLinksInApp },
            set: { self.settings.openLinksInApp = $0 }
        )
    }

    var recipeSource: Binding<RecipeSource> {
        Binding(
            get: { self.settings.recipeSource },
            set: { self.settings.recipeSource = $0 }
        )
    }

    var isHapticAvailable: Bool {
        settings.isHapticAvailable
    }

    // MARK: - URLs

    let developerWebsiteURL = URL(string: "https://brunopaiva.ch")!
    let privacyPolicyURL = URL(string: "https://brunopaiva.ch/confidentialite.html")!

    // MARK: - Initialization

    init(settings: SettingsManager) {
        self.settings = settings
    }
}
