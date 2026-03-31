//
//  CreateReview.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Fluent
import FluentPostgresDriver

struct CreateReview: Migration {
    private static let schemaName = "reviews"
    
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(CreateReview.schemaName)
            .id()
            .field("subject", .string)
            .field("body", .string)
            .field(
                "restaurant_id",
                .int64,
                .references(
                    "restaurant",
                    "id"
                )
            )
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema(CreateReview.schemaName).delete()
    }
}
