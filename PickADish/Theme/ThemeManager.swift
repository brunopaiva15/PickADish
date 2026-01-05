//
//  ThemeManager.swift
//  PickADish
//
//  Centralized theme management for the app
//

import SwiftUI

/// Manager that handles dynamic theming and color generation
@MainActor
final class ThemeManager: ObservableObject {

    // MARK: - Published Properties

    /// Current background color
    @Published private(set) var backgroundColor: Color = .clear

    /// Current foreground/text color
    @Published private(set) var foregroundColor: Color = .primary

    // MARK: - Dependencies

    private let settings: SettingsManager

    // MARK: - Initialization

    init(settings: SettingsManager) {
        self.settings = settings
        refreshColors()
    }

    // MARK: - Public Methods

    /// Refreshes colors based on current settings
    func refreshColors() {
        if settings.colorsEnabled {
            generateColorfulTheme()
        } else {
            useSystemColors()
        }
    }

    /// Generates new random colors
    func generateNewColors() {
        if settings.colorsEnabled {
            generateColorfulTheme()
        }
    }

    // MARK: - Private Methods

    private func useSystemColors() {
        backgroundColor = Color(uiColor: .systemBackground)
        foregroundColor = Color.primary
    }

    private func generateColorfulTheme() {
        if settings.lighterColorsEnabled {
            backgroundColor = Color(PastelColors.random())
        } else {
            backgroundColor = Color.random()
        }

        // Calculate contrasting foreground color
        foregroundColor = backgroundColor.contrastingColor()
    }
}

// MARK: - Pastel Colors

enum PastelColors {
    static let colors: [UIColor] = [
        UIColor(rgb: 0xFF9AA2),
        UIColor(rgb: 0xFFB7B2),
        UIColor(rgb: 0xFFDAC1),
        UIColor(rgb: 0xE2F0CB),
        UIColor(rgb: 0xB5EAD7),
        UIColor(rgb: 0xC7CEEA),
        UIColor(rgb: 0xBDD0C4),
        UIColor(rgb: 0x9AB7D3),
        UIColor(rgb: 0xF5D2D3),
        UIColor(rgb: 0xF7E1D3),
        UIColor(rgb: 0xDFCCF1),
        UIColor(rgb: 0xF0DBB0),
        UIColor(rgb: 0x89D1DC),
        UIColor(rgb: 0xF0D689),
        UIColor(rgb: 0xFFCCF9),
        UIColor(rgb: 0xECD4FF),
        UIColor(rgb: 0xD8FFD6),
        UIColor(rgb: 0xCCFFEE),
        UIColor(rgb: 0xCCDDFF),
        UIColor(rgb: 0xFFEEDD),
        UIColor(rgb: 0xCCCCEE)
    ]

    static func random() -> UIColor {
        colors.randomElement() ?? colors[0]
    }
}

// MARK: - UIColor Extensions

extension UIColor {
    /// Creates a UIColor from a hex RGB value
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            alpha: 1.0
        )
    }

    /// Generates a random color
    static func randomColor() -> UIColor {
        UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }

    /// Calculates the luminance of a color (WCAG formula)
    func luminance() -> CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        func adjust(_ component: CGFloat) -> CGFloat {
            component < 0.04045
                ? component / 12.92
                : pow((component + 0.055) / 1.055, 2.4)
        }

        return 0.2126 * adjust(red) + 0.7152 * adjust(green) + 0.0722 * adjust(blue)
    }

    /// Calculates the contrast ratio between two colors
    static func contrastRatio(between color1: UIColor, and color2: UIColor) -> CGFloat {
        let luminance1 = color1.luminance()
        let luminance2 = color2.luminance()
        let lighter = max(luminance1, luminance2)
        let darker = min(luminance1, luminance2)
        return (lighter + 0.05) / (darker + 0.05)
    }

    /// Returns an inverted color
    func inverted() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return UIColor(
            red: 1.0 - red,
            green: 1.0 - green,
            blue: 1.0 - blue,
            alpha: alpha
        )
    }
}

// MARK: - Color Extensions

extension Color {
    /// Generates a random color with good contrast
    static func random() -> Color {
        var color: UIColor
        var invertedColor: UIColor
        var contrastRatio: CGFloat

        repeat {
            color = UIColor.randomColor()
            invertedColor = color.inverted()
            contrastRatio = UIColor.contrastRatio(between: color, and: invertedColor)
        } while contrastRatio < 2.2

        return Color(uiColor: color)
    }

    /// Returns a contrasting color suitable for text
    func contrastingColor() -> Color {
        let uiColor = UIColor(self)
        return Color(uiColor: uiColor.inverted())
    }

    /// Common app colors
    static let appAccent = Color.orange
}
