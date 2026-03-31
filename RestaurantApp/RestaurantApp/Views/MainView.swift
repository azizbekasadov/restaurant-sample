//
//  MainView.swift
//  RestaurantApp
//
//  Created by Azizbek Asadov on 30.03.2026.
//

import SwiftUI

struct MainView: View {
    @StateObject private var httpClient = HTTPClient()
    
    @State private var isPresented = false
    @State private var errorMessage: String?
    
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        NavigationStack {
            List(httpClient.restaurants, id: \.id) { rest in
                NavigationLink {
                    
                } label: {
                    VStack {
                        rest.posterImage()?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Text(rest.title)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.blue)
                            .font(.system(size: 25))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .navigationTitle("Restaurant")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                await loadRestaurants()
            }
            .sheet(isPresented: $isPresented) {
                Task {
                    await self.loadRestaurants()
                }
            } content: {
                AddRestaurantView()
            }

        }
    }
    
    private func loadRestaurants() async {
        do {
            try await httpClient.getAllRestaurants()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
