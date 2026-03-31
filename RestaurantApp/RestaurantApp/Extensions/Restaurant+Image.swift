//
//  Restaurant+Image.swift
//  RestaurantApp
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import SwiftUI
import Foundation

extension Restaurant {
    func posterImage() -> Image? {
        guard let stringData = Data(base64Encoded: self.poster), let image = UIImage(data: stringData) else {
            debugPrint("Error: couldn't create UIImage")
            return nil
        }
        
        return Image(uiImage: image)
    }
}
