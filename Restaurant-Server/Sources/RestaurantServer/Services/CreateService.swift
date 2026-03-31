//
//  CreateService.swift
//  RestaurantServer
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Vapor
import Fluent

protocol CreateService {
    associatedtype T
    
    func create(
        _ content: any ContentContainer,
        on db: any Database
    ) throws -> EventLoopFuture<T>
}
