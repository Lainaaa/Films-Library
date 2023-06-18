//
//  FavoriteFilmRow.swift
//  Films Library
//
//  Created by Dmitrij Meidus on 13.06.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteFilmRow: View {
    let favorite: FavoriteFilms
    let urlIfImageNil = "https://www.computerhope.com/jargon/e/error.png"
    
    var body: some View {
        NavigationLink(destination: FilmDetailView(id: String(favorite.kinopoiskId))) {
            HStack {
                WebImage(url: URL(string: favorite.posterUrlPreview ?? urlIfImageNil ))
                    .resizable()
                    .frame(width: 75, height: 100)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Text(favorite.nameRu ?? favorite.nameEn ?? favorite.nameOriginal ?? "Error")
                        .foregroundStyle(Color.white)
                        .font(.title2)
                        .frame(width: 150, height: 25)
                    Text(favorite.descriptionOfFilm ?? "Error")
                        .frame(height: 75)
                        .foregroundStyle(Color.white)
                }
            }
        }
        }
}

#Preview {
//    FavoriteFilmRow()
}
