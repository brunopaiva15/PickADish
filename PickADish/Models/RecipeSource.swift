//
//  RecipeSource.swift
//  PickADish
//
//  Modernized architecture - 2024
//

import Foundation

/// Represents the available recipe websites
enum RecipeSource: String, CaseIterable, Codable, Identifiable {
    case marmiton = "Marmiton"
    case g750 = "750g"
    case cuisineAZ = "Cuisine AZ"
    case journalDesFemmes = "Journal des femmes"

    var id: String { rawValue }

    /// The base URL for searching recipes on this source
    var searchURLPrefix: String {
        switch self {
        case .marmiton:
            return "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt="
        case .g750:
            return "https://www.750g.com/recherche.htm?search="
        case .cuisineAZ:
            return "https://www.cuisineaz.com/recettes/recherche_terme.aspx?recherche="
        case .journalDesFemmes:
            return "https://cuisine.journaldesfemmes.fr/s/?f_libelle="
        }
    }

    /// Formats the dish name for URL search based on source requirements
    func formatDishNameForURL(_ dishName: String) -> String {
        // Remove accents and special characters
        var formatted = dishName
            .replacingOccurrences(of: "é", with: "e")
            .replacingOccurrences(of: "É", with: "E")
            .replacingOccurrences(of: "à", with: "a")
            .replacingOccurrences(of: "è", with: "e")
            .replacingOccurrences(of: "â", with: "a")
            .replacingOccurrences(of: "ï", with: "i")
            .replacingOccurrences(of: "ê", with: "e")
            .replacingOccurrences(of: "ô", with: "o")
            .replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "û", with: "u")

        // Marmiton uses hyphens instead of spaces
        switch self {
        case .marmiton:
            formatted = formatted.replacingOccurrences(of: " ", with: "-")
        default:
            formatted = formatted.replacingOccurrences(of: " ", with: "%20")
        }

        return formatted
    }

    /// Generates the full search URL for a dish
    func searchURL(for dishName: String) -> URL? {
        // Easter egg for "Space cake"
        if dishName == "Space cake" {
            return URL(string: "http://google.com/search?q=Pas%20tr%C3%A8s%20catholique...")
        }

        let formattedName = formatDishNameForURL(dishName)
        return URL(string: searchURLPrefix + formattedName)
    }
}
