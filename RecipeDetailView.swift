//
//  RecipeDetailView.swift
//  fetch-ios-app
//
//  Created by Zhihao Li on 03/30/25.
//

import SwiftUI
import URLImage
import SDWebImageSwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe  // Pass the recipe object

    var body: some View {
        VStack {
            if let imageUrl = recipe.photoUrlLarge, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    case .failure:
                        Image(systemName: "photo") // Fallback image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            Text(recipe.name)
                .font(.title)
                .padding()

            Text("Cuisine: \(recipe.cuisine)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
            
            // Add YouTube link row if the recipe has a YouTube URL
            if let youtubeUrl = recipe.youtubeUrl, let url = URL(string: youtubeUrl) {
                Link("Watch on YouTube", destination: url)
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .padding(.top, 5)
            }
        }
        .padding()
        .navigationTitle(recipe.name)
    }
}
