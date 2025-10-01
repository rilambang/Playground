//
//  ContentView.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: CocktailViewModel
    
    init() {
        // Dependency Injection
        self._viewModel = StateObject(wrappedValue: DependencyContainer.shared.makeCocktailViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                case .loaded(let cocktails):
                    CocktailListView(cocktails: cocktails)
                case .error(let error):
                    ErrorView(error: error) {
                        Task {
                            await viewModel.refreshCocktails()
                        }
                    }
                }
            }
            .navigationTitle("Cocktails")
            .refreshable {
                await viewModel.refreshCocktails()
            }
        }
        .task {
            await viewModel.loadCocktails()
        }
    }
}

// MARK: - Loading View
struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading cocktails...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Cocktail List View
struct CocktailListView: View {
    let cocktails: [Cocktail]
    
    var body: some View {
        List(cocktails) { cocktail in
            CocktailRowView(cocktail: cocktail)
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Cocktail Row View
struct CocktailRowView: View {
    let cocktail: Cocktail
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: cocktail.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(cocktail.name)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("Cocktail")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Error View
struct ErrorView: View {
    let error: NetworkError
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Oops! Something went wrong")
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Try Again") {
                onRetry()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
