//
//  Favorites.swift
//  Films Library
//
//  Created by Dmitrij Meidus on 13.06.23.
//

import SwiftUI
import SwiftData

struct Favorites: View {
    @Environment(\.modelContext) private var modelContext
    @Query var favorites: [FavoriteFilms]
    var body: some View {
        NavigationStack{
            ZStack{
                List{
                    if favorites.isEmpty{
                        Text("Вы еще не добавили ничего в избранное")
                            .font(.title)
                            .frame(alignment: .center)
                    }
                    ForEach(favorites) { favorite in
                        FavoriteFilmRow(favorite: favorite)
                    }
                    .onDelete(perform: deleteFavorite)
                    .listRowBackground(Color(red: 45/255, green: 39/255, blue: 52/255))
                }
                .scrollContentBackground(.hidden)
                .background(Color(red: 45/255, green: 39/255, blue: 52/255))
            }
        }
        .navigationTitle("Избранное")
    }
    
    /// Delete the selected film
    private func deleteFavorite(offsets: IndexSet) {
        withAnimation {
          for index in offsets {
            modelContext.delete(favorites[index])
          }
        }
      }
}

#Preview {
    Favorites()
}
