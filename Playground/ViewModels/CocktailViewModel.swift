//
//  CocktailViewModel.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation
import SwiftUI
import Combine

// MARK: - View State
enum ViewState {
    case loading
    case loaded([Cocktail])
    case error(NetworkError)
}

// MARK: - View Model (Single Responsibility Principle)
@MainActor
class CocktailViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    @Published var cocktails: [Cocktail] = []
    @Published var errorMessage: String?
    
    private let repository: CocktailRepositoryProtocol
    
    // Dependency Injection (Dependency Inversion Principle)
    init(repository: CocktailRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    func loadCocktails() async {
        state = .loading
        errorMessage = nil
        
        do {
            let fetchedCocktails = try await repository.fetchCocktails()
            cocktails = fetchedCocktails
            state = .loaded(fetchedCocktails)
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
            state = .error(error)
        } catch {
            errorMessage = "An unexpected error occurred"
            state = .error(.networkError(error))
        }
    }
    
    func refreshCocktails() async {
        await loadCocktails()
    }
}
