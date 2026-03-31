//
//  HTTPClient.swift
//  RestaurantApp
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Combine
import Foundation

final class HTTPClient: ObservableObject {
    enum Error: Swift.Error {
        case invalidURL
    }
    
    @Published var restaurants: [Restaurant] = [Restaurant]()
    @Published var reviews: [Review]? = []
    
    func deleteRestaurant(restaurant: Restaurant) async throws -> Bool {
        guard let id = restaurant.id,
                let url = URL(string: "http://localhost:8080/restaurant/\(id)") else {
            throw Error.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return !data.isEmpty
    }
    
    func getAllRestaurants() async throws {
        guard let url = URL(string: "http://localhost:8080/restaurant") else {
            throw Error.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
        
        await MainActor.run {
            self.restaurants = restaurants
        }
    }
    
    func saveRestaurant(
        restaurant: Restaurant
    ) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/restaurant") else {
            throw Error.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(restaurant)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return !data.isEmpty
    }
    
    func getReviewsByRestaurant(restaurant: Restaurant) async throws {
        guard let id = restaurant.id,
              let url = URL(string: "http://localhost:8080/restaurant/\(id)/reviews") else {
            throw Error.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let reviews = try JSONDecoder().decode([Review].self, from: data)
        
        await MainActor.run {
            self.reviews = reviews
        }
    }
    
    func saveReview(review: Review) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/reviews") else {
            throw Error.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(review)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return !data.isEmpty
    }
}
