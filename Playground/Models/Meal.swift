//
//  Meal.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation

// MARK: - Meal Response Models
struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let id: String
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURL = "strMealThumb"
    }
}
