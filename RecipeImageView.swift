//
//  RecipeImageView.swift
//  fetch-ios-app
//
//  Created by Zhihao Li on 03/30/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeImageView: View {
    var url: URL?

    var body: some View {
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
}
#Preview {
    RecipeImageView(url: URL(string: "https://www.themealdb.com/images/media/meals/yypvst1511386427.jpg"))
}
