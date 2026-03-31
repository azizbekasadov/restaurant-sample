//
//  AddRestaurantView.swift
//  RestaurantApp
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import SwiftUI
import PhotosUI

struct AddRestaurantView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var posterPicker: PhotosPickerItem? = nil
    @State private var selectedPoster: Data? = nil
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    TextField("Enter name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter Address", text: $address)
                        .textFieldStyle(.roundedBorder)
                    
                    PhotosPicker(
                        selection: $posterPicker,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Text("Select Poster")
                    }
                    .onChange(of: posterPicker) { _, newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                selectedPoster = data
                            }
                        }
                    }
                    
                    if let selectedPoster, let uiImage = UIImage(data: selectedPoster) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    }
                    
                    Button("Add Restaurant") {
                        Task {
                            await self.saveRestaurant()
                        }
                    }
                    .padding(8)
                    .foregroundStyle(Color.white)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                .background(Color.black)
            }
            .navigationTitle("Add Restaurant")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveRestaurant() async {
        let posterBase64 = selectedPoster?.base64EncodedString() ?? ""
        let restaurant = Restaurant(
            title: name,
            poster: posterBase64,
            address: address
        )
        
        do {
            let success = try await HTTPClient().saveRestaurant(
                restaurant: restaurant
            )
            
            if success {
                dismiss()
            } else {
                errorMessage = "Failed to save restaurant"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
