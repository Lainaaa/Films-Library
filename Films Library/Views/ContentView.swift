//
//  ContentView.swift
//  Film Library
//
//  Created by Dmitrij Meidus on 05.03.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var bestFilms: FilmData?
    @State private var awaitFilms: FilmData?
    
    //Color of header
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor:  UIColor.red]
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 45/255, green: 39/255, blue: 52/255, alpha: 1)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                loadFilmsToTheView(for: TopFilmTypes.best.rawValue, films: bestFilms?.films) { filmData in
                    self.bestFilms = filmData
                }
                loadFilmsToTheView(for: TopFilmTypes.await.rawValue, films: awaitFilms?.films) { filmData in
                    self.awaitFilms = filmData
                }
            }
            .background(Color(red: 45/255, green: 39/255, blue: 52/255))
            .navigationBarTitle("Movie Library", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: Favorites()) {
                        Image(systemName: "star.fill")
                            .renderingMode(.template)
                            .foregroundStyle(.red, .red, .red)
                    }
                }
            }
        }
        .tint(.red)
    }
    
    private func loadFilmsToTheView(for list: String, films: [MovieItem]?, onLoad: @escaping (FilmData) -> Void) -> some View {
        if let films = films {
            if list == "TOP_250_BEST_FILMS"{
                return AnyView(FilmsScrollView(films: films, header: "Лучшие"))
            }else{
                return AnyView(FilmsScrollView(films: films, header: "Премьера"))
            }
        } else {
            return AnyView(ProgressView().onAppear {
                Task {
                    do {
                        let filmData = try await FilmLoader().loadListOfFilms(list: list)
                            onLoad(filmData)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
