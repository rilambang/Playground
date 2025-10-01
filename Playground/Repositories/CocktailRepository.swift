//
//  CocktailRepository.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation

// MARK: - Repository Protocol (Dependency Inversion Principle)
protocol CocktailRepositoryProtocol {
    func fetchCocktails() async throws -> [Cocktail]
}

// MARK: - Concrete Repository Implementation
class CocktailRepository: CocktailRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    
    // Dependency Injection (Dependency Inversion Principle)
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCocktails() async throws -> [Cocktail] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let response: CocktailResponse = try await networkService.fetch(CocktailResponse.self, from: url)
        return response.drinks
    }
}
