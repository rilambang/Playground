//
//  Cocktail.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation

// MARK: - Cocktail Response Models
struct CocktailResponse: Codable {
    let drinks: [Cocktail]
}

struct Cocktail: Codable, Identifiable {
    let id: String
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
    }
}

// MARK: - Error Types
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
