//
//  File.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Fluent
import FluentPostgresDriver

struct CreateRestaurant: Migration {
    private static let schemaName = "restaurant"
    
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(CreateRestaurant.schemaName)
            .id()
            .field("title", .string)
            .field("poster", .string)
            .field("address", .string)
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(CreateRestaurant.schemaName).delete()
    }
}
