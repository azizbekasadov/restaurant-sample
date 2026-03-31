//
//  File.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent
import Foundation

final class Restaurant: Model, Content {
    static let schema: String = "restaurant" //
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "poster")
    var poster: String
    
    @Field(key: "address")
    var address: String
    
    @Children(for: \.$restaurant)
    var reviews: [Review]
    
    init() {}
    
    init(id: Int?, title: String, address: String, poster: String) {
        self.id = id
        self.title = title
        self.address = address
        self.poster = poster
    }
}
