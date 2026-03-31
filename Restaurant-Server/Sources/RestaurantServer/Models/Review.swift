//
//  File.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent
import Foundation
import FluentPostgresDriver

final class Review: Model, Content {
    static let schema = "reviews"
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "restaurant_id")
    var restaurant: Restaurant
    
    init() {}
    
    init(id: Int? = nil, title: String, body: String, restaurantId: Int) {
        self.id = id
        self.title = title
        self.body = body
        self.$restaurant.id = restaurantId
    }
}
