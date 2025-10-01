//
//  MealViewModel.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation
import SwiftUI
import Combine

// MARK: - View State
enum MealViewState {
    case loading
    case loaded([Meal])
    case error(NetworkError)
}

// MARK: - View Model (Single Responsibility Principle)
@MainActor
class MealViewModel: ObservableObject {
    @Published var state: MealViewState = .loading
    @Published var meals: [Meal] = []
    @Published var errorMessage: String?
    
    private let repository: MealRepositoryProtocol
    
    // Dependency Injection (Dependency Inversion Principle)
    init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    func loadMeals() async {
        state = .loading
        errorMessage = nil
        
        do {
            let fetchedMeals = try await repository.fetchMeals()
            meals = fetchedMeals
            state = .loaded(fetchedMeals)
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
            state = .error(error)
        } catch {
            errorMessage = "An unexpected error occurred"
            state = .error(.networkError(error))
        }
    }
    
    func refreshMeals() async {
        await loadMeals()
    }
}
