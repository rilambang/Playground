# Cocktail App - SOLID Principles Implementation

This SwiftUI app fetches cocktail data from The Cocktail DB API while following SOLID principles.

## SOLID Principles Implementation

### 1. Single Responsibility Principle (SRP)
- **CocktailViewModel**: Handles only UI state and business logic for cocktail display
- **NetworkService**: Responsible only for network operations
- **CocktailRepository**: Manages only cocktail data access
- **DependencyContainer**: Manages only dependency injection

### 2. Open/Closed Principle (OCP)
- **NetworkServiceProtocol**: Open for extension through protocol conformance
- **CocktailRepositoryProtocol**: Can be extended with new implementations without modifying existing code
- **View Components**: Can be extended with new features without modifying existing views

### 3. Liskov Substitution Principle (LSP)
- Any implementation of `NetworkServiceProtocol` can replace `NetworkService` without breaking functionality
- Any implementation of `CocktailRepositoryProtocol` can replace `CocktailRepository` seamlessly

### 4. Interface Segregation Principle (ISP)
- **NetworkServiceProtocol**: Contains only network-related methods
- **CocktailRepositoryProtocol**: Contains only cocktail-specific data access methods
- Protocols are focused and don't force unnecessary dependencies

### 5. Dependency Inversion Principle (DIP)
- **CocktailViewModel** depends on `CocktailRepositoryProtocol` abstraction, not concrete implementation
- **CocktailRepository** depends on `NetworkServiceProtocol` abstraction
- **DependencyContainer** manages all dependencies and provides abstractions

## Architecture Overview

```
ContentView
    ↓ (depends on)
CocktailViewModel
    ↓ (depends on)
CocktailRepositoryProtocol
    ↓ (depends on)
NetworkServiceProtocol
```

## Features

- ✅ Fetches cocktail data from The Cocktail DB API
- ✅ Displays cocktails in a beautiful list with images
- ✅ Loading states with progress indicators
- ✅ Error handling with retry functionality
- ✅ Pull-to-refresh support
- ✅ Async image loading
- ✅ Clean architecture with dependency injection
- ✅ SOLID principles compliance

## API Endpoint

The app fetches data from:
```
https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail
```

## File Structure

```
Playground/
├── Models/
│   └── Cocktail.swift          # Data models
├── Services/
│   └── NetworkService.swift    # Network layer
├── Repositories/
│   └── CocktailRepository.swift # Data access layer
├── ViewModels/
│   └── CocktailViewModel.swift # Business logic
├── DependencyContainer.swift   # Dependency injection
└── ContentView.swift           # UI layer
```
