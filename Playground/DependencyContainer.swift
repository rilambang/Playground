//
//  DependencyContainer.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation

// MARK: - Dependency Container (Dependency Inversion Principle)
class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    // MARK: - Services
    lazy var networkService: NetworkServiceProtocol = {
        return NetworkService()
    }()
    
    // MARK: - Repositories
    lazy var cocktailRepository: CocktailRepositoryProtocol = {
        return CocktailRepository(networkService: networkService)
    }()
    
    lazy var mealRepository: MealRepositoryProtocol = {
        return MealRepository(networkService: networkService)
    }()
    
    // MARK: - View Models
    func makeCocktailViewModel() -> CocktailViewModel {
        return CocktailViewModel(repository: cocktailRepository)
    }
    
    func makeMealViewModel() -> MealViewModel {
        return MealViewModel(repository: mealRepository)
    }
}
