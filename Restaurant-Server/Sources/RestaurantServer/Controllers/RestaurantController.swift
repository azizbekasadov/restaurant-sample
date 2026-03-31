//
//  RestaurantController.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent
import Foundation

final class RestaurantController {
    let restaurantService: RestaurantService
    
    init(restaurantService: RestaurantService) {
        self.restaurantService = restaurantService
    }
    
    func create(_ request: Request) throws -> EventLoopFuture<Restaurant> {
        try restaurantService.create(request.content, on: request.db)
    }
    
    func all(_ request: Request) throws -> EventLoopFuture<[Restaurant]> {
        try restaurantService.all(request.db)
    }
    
    func getById(_ request: Request) throws -> EventLoopFuture<Restaurant> {
        try restaurantService.getItemsById(request.db, with: request.parameters)
    }
    
    func delete(_ request: Request) throws -> EventLoopFuture<HTTPStatus> {
        try restaurantService.delete(request.db, with: request.parameters)
    }
}
