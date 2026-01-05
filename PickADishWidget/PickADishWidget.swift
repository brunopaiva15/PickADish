//
//  PickADishWidget.swift
//  PickADishWidget
//
//  A widget that shows a random dish suggestion
//

import WidgetKit
import SwiftUI

// MARK: - Widget Data

/// Simple dish data for the widget (shared with main app models)
struct WidgetDish {
    let name: String
    let category: String
    let symbolName: String

    static let categories: [(name: String, symbol: String, dishes: [String])] = [
        ("Entrées", "leaf.fill", [
            "Foie gras", "Salade césar", "Quiche lorraine", "Soupe à l'oignon",
            "Carpaccio de boeuf", "Salade niçoise", "Taboulé"
        ]),
        ("Plats", "fork.knife", [
            "Boeuf bourguignon", "Blanquette de veau", "Coq au vin", "Ratatouille",
            "Tartiflette", "Cassoulet", "Gratin dauphinois", "Pizza", "Sushis"
        ]),
        ("Desserts", "birthday.cake.fill", [
            "Crème brûlée", "Tarte Tatin", "Mousse au chocolat", "Île flottante",
            "Macarons", "Profiteroles", "Tiramisu", "Cheesecake"
        ]),
        ("Boissons", "cup.and.saucer.fill", [
            "Mojito", "Sangria", "Smoothie aux fraises", "Chocolat chaud",
            "Thé à la menthe", "Café glacé", "Limonade"
        ])
    ]

    static func random() -> WidgetDish {
        let category = categories.randomElement()!
        let dishName = category.dishes.randomElement()!
        return WidgetDish(name: dishName, category: category.name, symbolName: category.symbol)
    }
}

// MARK: - Timeline Entry

struct DishEntry: TimelineEntry {
    let date: Date
    let dish: WidgetDish
}

// MARK: - Timeline Provider

struct DishProvider: TimelineProvider {
    func placeholder(in context: Context) -> DishEntry {
        DishEntry(date: Date(), dish: WidgetDish(name: "Boeuf bourguignon", category: "Plats", symbolName: "fork.knife"))
    }

    func getSnapshot(in context: Context, completion: @escaping (DishEntry) -> Void) {
        let entry = DishEntry(date: Date(), dish: WidgetDish.random())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DishEntry>) -> Void) {
        var entries: [DishEntry] = []
        let currentDate = Date()

        // Generate a new dish every hour
        for hourOffset in 0..<24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = DishEntry(date: entryDate, dish: WidgetDish.random())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Widget View

struct PickADishWidgetEntryView: View {
    var entry: DishProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            mediumWidget
        case .systemLarge:
            largeWidget
        default:
            smallWidget
        }
    }

    var smallWidget: some View {
        VStack(spacing: 8) {
            Image(systemName: entry.dish.symbolName)
                .font(.title)
                .foregroundStyle(.orange)

            Text(entry.dish.name)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .lineLimit(2)

            Text(entry.dish.category)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }

    var mediumWidget: some View {
        HStack(spacing: 16) {
            Image(systemName: entry.dish.symbolName)
                .font(.system(size: 40))
                .foregroundStyle(.orange)
                .frame(width: 60)

            VStack(alignment: .leading, spacing: 4) {
                Text("Idée du moment")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(entry.dish.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)

                Text(entry.dish.category)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }

    var largeWidget: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "fork.knife.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.orange)
                Text("PickADish")
                    .font(.headline)
                Spacer()
            }

            Spacer()

            Image(systemName: entry.dish.symbolName)
                .font(.system(size: 50))
                .foregroundStyle(.orange)

            Text(entry.dish.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(entry.dish.category)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Text("Appuyez pour voir la recette")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

// MARK: - Widget Configuration

@main
struct PickADishWidget: Widget {
    let kind: String = "PickADishWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DishProvider()) { entry in
            PickADishWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Idée de plat")
        .description("Découvrez une nouvelle idée de plat chaque heure")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Preview

#Preview(as: .systemSmall) {
    PickADishWidget()
} timeline: {
    DishEntry(date: .now, dish: WidgetDish(name: "Boeuf bourguignon", category: "Plats", symbolName: "fork.knife"))
}

#Preview(as: .systemMedium) {
    PickADishWidget()
} timeline: {
    DishEntry(date: .now, dish: WidgetDish(name: "Tarte Tatin", category: "Desserts", symbolName: "birthday.cake.fill"))
}
