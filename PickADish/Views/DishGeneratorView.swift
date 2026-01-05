//
//  DishGeneratorView.swift
//  PickADish
//
//  View for generating random dishes
//

import SwiftUI

struct DishGeneratorView: View {

    // MARK: - ViewModel

    @StateObject var viewModel: DishGeneratorViewModel

    // MARK: - State

    @State private var showDetail = false
    @State private var animateDish = false

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background
            viewModel.backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.3), value: viewModel.backgroundColor)

            VStack {
                Spacer()

                // Dish name display
                dishNameView

                Spacer()

                // Bottom controls
                VStack(spacing: 16) {
                    // Back button
                    if viewModel.canGoBack {
                        backButton
                            .transition(.opacity.combined(with: .scale))
                    }

                    // Generate button
                    generateButton
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 30)
        }
        .navigationTitle(viewModel.category.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(colorSchemeForBackground, for: .navigationBar)
        .gesture(swipeGesture)
        .sheet(isPresented: $showDetail) {
            if let dish = viewModel.currentDish {
                DishDetailView(
                    dish: dish,
                    isFavorite: viewModel.isCurrentDishFavorite(),
                    recipeURL: viewModel.recipeURL(),
                    sharingText: viewModel.sharingText,
                    openInApp: viewModel.shouldOpenInApp,
                    onToggleFavorite: {
                        _ = viewModel.toggleFavorite()
                    }
                )
            }
        }
        .animation(.spring(response: 0.3), value: viewModel.canGoBack)
    }

    // MARK: - Subviews

    private var dishNameView: some View {
        Group {
            if let dish = viewModel.currentDish {
                Text(dish.name)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(viewModel.foregroundColor)
                    .scaleEffect(animateDish ? 1.0 : 0.8)
                    .opacity(animateDish ? 1.0 : 0.0)
                    .onTapGesture {
                        showDetail = true
                    }
            } else {
                Text("👇")
                    .font(.system(size: 60))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }

    private var backButton: some View {
        Button {
            withAnimation(.spring(response: 0.3)) {
                animateDish = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.goBack()
                withAnimation(.spring(response: 0.3)) {
                    animateDish = true
                }
            }
        } label: {
            Image(systemName: "arrow.uturn.backward")
                .font(.title2)
                .foregroundStyle(viewModel.foregroundColor)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .stroke(viewModel.foregroundColor, lineWidth: 2)
                )
        }
    }

    private var generateButton: some View {
        Button {
            withAnimation(.spring(response: 0.3)) {
                animateDish = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.generateNewDish()
                withAnimation(.spring(response: 0.3)) {
                    animateDish = true
                }
            }
        } label: {
            Text(viewModel.category.generateButtonTitle)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.backgroundColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(viewModel.foregroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.foregroundColor)
    }

    // MARK: - Computed Properties

    private var colorSchemeForBackground: ColorScheme {
        // Determine if background is light or dark to set appropriate toolbar style
        let uiColor = UIColor(viewModel.backgroundColor)
        return uiColor.luminance() > 0.5 ? .light : .dark
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 50)
            .onEnded { value in
                let horizontalAmount = value.translation.width
                if horizontalAmount > 0 {
                    // Swipe right - generate new
                    viewModel.handleSwipeRight()
                    withAnimation(.spring(response: 0.3)) {
                        animateDish = true
                    }
                } else {
                    // Swipe left - go back
                    viewModel.handleSwipeLeft()
                    withAnimation(.spring(response: 0.3)) {
                        animateDish = true
                    }
                }
            }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DishGeneratorView(
            viewModel: DishGeneratorViewModel(
                category: .plats,
                dishService: DishService(),
                favoritesManager: FavoritesManager(),
                settings: SettingsManager()
            )
        )
    }
}
