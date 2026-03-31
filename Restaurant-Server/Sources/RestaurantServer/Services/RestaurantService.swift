//
//  RestaurantService.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent
import Foundation

final class RestaurantService: CreateService {
    
    func create(
        _ content: any ContentContainer,
        on db: any Database
    ) throws -> EventLoopFuture<Restaurant> {
        let restaurant = try content.decode(Restaurant.self)
        return restaurant.create(on: db).map { restaurant }
    }
    
    func getItemsById(_ db: any Database, with parameters: Parameters) throws -> EventLoopFuture<Restaurant> {
        Restaurant.query(on: db).filter(
            .id,
            .equal,
            parameters.get("restaurantId", as: UUID.self))
            .with(\.$reviews)
            .first()
            .unwrap(or: Abort(.notFound))
    }
    
    func all(_ db: any Database) throws -> EventLoopFuture<[Restaurant]> {
        Restaurant.query(on: db).all()
    }
    
    
    func delete(
        _ db: any Database,
        with parameters: Parameters
    ) throws -> EventLoopFuture<HTTPStatus> {
        Restaurant.find(parameters.get("restaurantId"), on: db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: db) }
        .transform(to: .ok)
    }
}
