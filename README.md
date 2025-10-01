# Food & Drink App - SOLID Principles Implementation

This SwiftUI app fetches cocktail data from The Cocktail DB API and seafood meal data from The Meal DB API while following SOLID principles.

## SOLID Principles Implementation

### 1. Single Responsibility Principle (SRP)
- **CocktailViewModel**: Handles only UI state and business logic for cocktail display
- **MealViewModel**: Handles only UI state and business logic for meal display
- **NetworkService**: Responsible only for network operations
- **CocktailRepository**: Manages only cocktail data access
- **MealRepository**: Manages only meal data access
- **DependencyContainer**: Manages only dependency injection

### 2. Open/Closed Principle (OCP)
- **NetworkServiceProtocol**: Open for extension through protocol conformance
- **CocktailRepositoryProtocol & MealRepositoryProtocol**: Can be extended with new implementations without modifying existing code
- **View Components**: Can be extended with new features without modifying existing views

### 3. Liskov Substitution Principle (LSP)
- Any implementation of `NetworkServiceProtocol` can replace `NetworkService` without breaking functionality
- Any implementation of `CocktailRepositoryProtocol` or `MealRepositoryProtocol` can replace their concrete implementations seamlessly

### 4. Interface Segregation Principle (ISP)
- **NetworkServiceProtocol**: Contains only network-related methods
- **CocktailRepositoryProtocol**: Contains only cocktail-specific data access methods
- **MealRepositoryProtocol**: Contains only meal-specific data access methods
- Protocols are focused and don't force unnecessary dependencies

### 5. Dependency Inversion Principle (DIP)
- **CocktailViewModel** depends on `CocktailRepositoryProtocol` abstraction, not concrete implementation
- **MealViewModel** depends on `MealRepositoryProtocol` abstraction, not concrete implementation
- **CocktailRepository & MealRepository** depend on `NetworkServiceProtocol` abstraction
- **DependencyContainer** manages all dependencies and provides abstractions

## Architecture Overview

The app follows a clean architecture pattern with TabView navigation:
```
TabView
├── CocktailTabView → CocktailViewModel → CocktailRepository → NetworkService
└── MealTabView → MealViewModel → MealRepository → NetworkService
```

## Features

- ✅ **Dual API Integration**: Fetches cocktails from The Cocktail DB and seafood meals from The Meal DB
- ✅ **Tab Navigation**: Switch between Cocktails and Meals tabs
- ✅ **Beautiful UI**: List views with images, names, and categories
- ✅ **Loading States**: Progress indicators during data fetching
- ✅ **Error Handling**: User-friendly error messages with retry functionality
- ✅ **Pull-to-Refresh**: Swipe down to refresh data on both tabs
- ✅ **Async Image Loading**: Smooth image loading with placeholders
- ✅ **Dependency Injection**: Clean separation of concerns
- ✅ **SOLID Principles**: Full compliance with all SOLID principles

## API Endpoints

The app fetches data from:
```
Cocktails: https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail
Meals: https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
```

## File Structure

```
Playground/
├── Models/
│   ├── Cocktail.swift          # Cocktail data models
│   └── Meal.swift              # Meal data models
├── Services/
│   └── NetworkService.swift    # Network layer
├── Repositories/
│   ├── CocktailRepository.swift # Cocktail data access layer
│   └── MealRepository.swift    # Meal data access layer
├── ViewModels/
│   ├── CocktailViewModel.swift # Cocktail business logic
│   └── MealViewModel.swift     # Meal business logic
├── DependencyContainer.swift   # Dependency injection
└── ContentView.swift           # UI layer with TabView
```
