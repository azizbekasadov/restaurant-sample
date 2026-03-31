//
//  File.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent
import Foundation

final class ReviewsController {
    let reviewsService: ReviewsService
    
    init(reviewsService: ReviewsService) {
        self.reviewsService = reviewsService
    }
    
    func create(_ request: Request) throws -> EventLoopFuture<Review> {
        try reviewsService.create(request.content, on: request.db)
    }
    
    func getByRestaurantId(_ request: Request) throws -> EventLoopFuture<[Review]> {
        try reviewsService.getItemsById(request.db, with: request.parameters)
    }
}
