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
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor:  UIColor.white]
    }
    
    var body: some View {
        NavigationView {
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
        }
    }
    
    //
    private func loadFilmsToTheView(for list: String, films: [MovieItem]?, onLoad: @escaping (FilmData) -> Void) -> some View {
        if let films = films {
            return AnyView(FilmsScrollView(films: films))
        } else {
            return AnyView(ProgressView().onAppear {
                FilmLoader().loadListOfFilms(list: list, completion: { (filmData: FilmData?) in
                    guard let filmData = filmData else {
                        print("Could not read data")
                        return
                    }
                    onLoad(filmData)
                })
            })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
