//
//  NetworkService.swift
//  Playground
//
//  Created by Muhammad Ilham Rilambang on 01/10/25.
//

import Foundation

// MARK: - Network Service Protocol (Interface Segregation Principle)
protocol NetworkServiceProtocol {
    func fetch<T: Codable>(_ type: T.Type, from url: URL) async throws -> T
}

// MARK: - Concrete Network Service Implementation
class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Codable>(_ type: T.Type, from url: URL) async throws -> T {
        do {
            print("🌐 Fetching from URL: \(url)")
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Invalid response type")
                throw NetworkError.networkError(URLError(.badServerResponse))
            }
            
            print("📡 HTTP Status Code: \(httpResponse.statusCode)")
            
            guard httpResponse.statusCode == 200 else {
                print("❌ Bad status code: \(httpResponse.statusCode)")
                throw NetworkError.networkError(URLError(.badServerResponse))
            }
            
            guard !data.isEmpty else {
                print("❌ Empty data received")
                throw NetworkError.noData
            }
            
            // Print raw data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📄 Raw JSON (first 200 chars): \(String(jsonString.prefix(200)))")
            }
            
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                print("✅ Successfully decoded data")
                return decodedData
            } catch let decodingError {
                print("❌ Decoding error: \(decodingError)")
                throw NetworkError.decodingError
            }
        } catch let error as NetworkError {
            print("❌ Network error: \(error)")
            throw error
        } catch {
            print("❌ Unexpected error: \(error)")
            throw NetworkError.networkError(error)
        }
    }
}
