//
//  Review.swift
//  RestaurantApp
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import Foundation

struct Review: Codable {
    var id: Int?
    var title: String
    var body: String
    var restaurant: Restaurant?
}
