//
//  SettingsManager.swift
//  PickADish
//
//  Service responsible for managing app settings with persistence
//

import Foundation
import SwiftUI

/// Manager that handles app settings with UserDefaults persistence
@MainActor
final class SettingsManager: ObservableObject {

    // MARK: - Keys

    private enum Keys {
        static let colorsEnabled = "PAD_COLORS"
        static let lighterColors = "PAD_LIGHTER_COLORS"
        static let hapticEnabled = "PAD_TAPTIC"
        static let swipeEnabled = "PAD_SLIDE"
        static let openInApp = "PAD_OPENINAPP"
        static let recipeSource = "PAD_SOURCE"
        static let showFirstTimePopup = "PAD_SHOW_POPUP_FIRST_TIME"
        static let hasLaunchedBefore = "launchedBefore"
    }

    // MARK: - Published Properties

    /// Enable colorful backgrounds
    @Published var colorsEnabled: Bool {
        didSet { save(colorsEnabled, forKey: Keys.colorsEnabled) }
    }

    /// Use lighter/pastel colors
    @Published var lighterColorsEnabled: Bool {
        didSet { save(lighterColorsEnabled, forKey: Keys.lighterColors) }
    }

    /// Enable haptic feedback
    @Published var hapticEnabled: Bool {
        didSet { save(hapticEnabled, forKey: Keys.hapticEnabled) }
    }

    /// Enable swipe gestures
    @Published var swipeEnabled: Bool {
        didSet { save(swipeEnabled, forKey: Keys.swipeEnabled) }
    }

    /// Open recipe links in-app
    @Published var openLinksInApp: Bool {
        didSet { save(openLinksInApp, forKey: Keys.openInApp) }
    }

    /// Selected recipe source
    @Published var recipeSource: RecipeSource {
        didSet { save(recipeSource.rawValue, forKey: Keys.recipeSource) }
    }

    /// Show first time welcome popup
    @Published var showFirstTimePopup: Bool {
        didSet { save(showFirstTimePopup, forKey: Keys.showFirstTimePopup) }
    }

    // MARK: - Computed Properties

    /// Whether haptic feedback is available on this device
    var isHapticAvailable: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    // MARK: - Initialization

    init() {
        let defaults = UserDefaults.standard

        // Check if first launch
        let hasLaunchedBefore = defaults.bool(forKey: Keys.hasLaunchedBefore)

        if !hasLaunchedBefore {
            // Set default values for first launch
            self.colorsEnabled = true
            self.lighterColorsEnabled = true
            self.hapticEnabled = true
            self.swipeEnabled = false
            self.openLinksInApp = true
            self.recipeSource = .marmiton
            self.showFirstTimePopup = true

            // Save defaults
            defaults.set(true, forKey: Keys.colorsEnabled)
            defaults.set(true, forKey: Keys.lighterColors)
            defaults.set(true, forKey: Keys.hapticEnabled)
            defaults.set(false, forKey: Keys.swipeEnabled)
            defaults.set(true, forKey: Keys.openInApp)
            defaults.set(RecipeSource.marmiton.rawValue, forKey: Keys.recipeSource)
            defaults.set(true, forKey: Keys.showFirstTimePopup)
            defaults.set(true, forKey: Keys.hasLaunchedBefore)
        } else {
            // Load existing values
            self.colorsEnabled = defaults.bool(forKey: Keys.colorsEnabled)
            self.lighterColorsEnabled = defaults.bool(forKey: Keys.lighterColors)
            self.hapticEnabled = defaults.bool(forKey: Keys.hapticEnabled)
            self.swipeEnabled = defaults.bool(forKey: Keys.swipeEnabled)
            self.openLinksInApp = defaults.bool(forKey: Keys.openInApp)
            self.showFirstTimePopup = defaults.bool(forKey: Keys.showFirstTimePopup)

            // Load recipe source with fallback
            if let sourceString = defaults.string(forKey: Keys.recipeSource),
               let source = RecipeSource(rawValue: sourceString) {
                self.recipeSource = source
            } else {
                self.recipeSource = .marmiton
            }
        }
    }

    // MARK: - Public Methods

    /// Triggers haptic feedback if enabled
    func triggerHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        guard hapticEnabled && isHapticAvailable else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    /// Triggers light haptic feedback
    func triggerLightHaptic() {
        guard hapticEnabled && isHapticAvailable else { return }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    /// Marks the first time popup as shown
    func markFirstTimePopupShown() {
        showFirstTimePopup = false
    }

    // MARK: - Private Methods

    private func save(_ value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    private func save(_ value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
