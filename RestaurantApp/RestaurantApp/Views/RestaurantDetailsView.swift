//
//  RestaurantDetailsView.swift
//  RestaurantApp
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import SwiftUI

struct RestaurantDetailsView: View {
    let restaurant: Restaurant
    
    @State private var reviewTitle: String = ""
    @State private var reviewBody: String = ""
    @State private var errorMessage: String?
    
    @StateObject private var httpClient = HTTPClient()
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Form {
            restaurant.posterImage()?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Section(
                header: Text("ADD A REVIEW")
                    .fontWeight(.bold)
            ) {
                VStack(alignment: .center, spacing: 10) {
                    TextField("Enter Title", text: $reviewTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter Body", text: $reviewBody)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Save") {
                        Task {
                            await self.saveReview()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 6.0))
                    .buttonStyle(.plain)
                }
            }
            
            Section(
                header: Text("REVIEWS").fontWeight(.bold)) {
                    ForEach(httpClient.reviews ?? [], id: \.id) { review in
                        Text(review.title)
                    }
                }
        }
        .task {
            await getReviews()
        }
        .navigationTitle(restaurant.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await deleteRestaurant()
                    }
                } label: {
                    Image(systemName: "trash.fill")
                }
            }
        }
    }
    
    private func getReviews() async {
        do {
            try await httpClient.getReviewsByRestaurant(restaurant: restaurant)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func deleteRestaurant() async {
        do {
            let result = try await httpClient.deleteRestaurant(
                restaurant: restaurant
            )
            
            if result {
                dismiss()
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func saveReview() async {
        let review = Review(title: self.reviewTitle, body: self.reviewBody, restaurant: self.restaurant)
        
        do {
            let res1 = try await httpClient.saveReview(review: review)
            
            if res1 {
                try await httpClient.getReviewsByRestaurant(restaurant: restaurant)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
