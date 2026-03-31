//
//  ReviewsService.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent
import Foundation

final class ReviewsService: CreateService {
    func create(
        _ content: any ContentContainer,
        on db: any Database
    ) throws -> EventLoopFuture<Review> {
        let review = try content.decode(Review.self)
        return review.save(on: db).map { review }
    }
    
    func getItemsById(_ db: any Database, with parameters: Parameters) throws -> EventLoopFuture<[Review]> {
        guard let restaurantId = parameters.get("restaurantId", as: Int.self) else {
            throw Abort(.notFound)
        }
        
        return Review
            .query(on: db)
            .filter(\.$restaurant.$id, .equal, restaurantId)
            .with(\.$restaurant)
            .all()
    }
}
