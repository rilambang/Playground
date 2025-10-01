//
//  MealRepository.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation

// MARK: - Repository Protocol (Dependency Inversion Principle)
protocol MealRepositoryProtocol {
    func fetchMeals() async throws -> [Meal]
}

// MARK: - Concrete Repository Implementation
class MealRepository: MealRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"
    
    // Dependency Injection (Dependency Inversion Principle)
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMeals() async throws -> [Meal] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let response: MealResponse = try await networkService.fetch(MealResponse.self, from: url)
        return response.meals
    }
}
