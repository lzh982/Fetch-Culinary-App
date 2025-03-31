//
//  RecipeListView.swift
//  fetch-ios-app
//
//  Created by Zhihao Li on 03/20/25.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var recipeListViewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            List(recipeListViewModel.recipe, id: \.uuid) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    HStack {
                        if let imageUrl = recipe.photoUrlSmall, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                case .failure:
                                    Image(systemName: "photo") // Fallback image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }

                        Text(recipe.name)
                            .font(.headline)
                    }
                }
                
            }
            .onAppear {
                recipeListViewModel.fetchMeals()
            }
            .navigationBarTitle("Dessert Recipes")
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
