//
//  ContentView.swift
//  Film Library
//
//  Created by Dmitrij Meidus on 05.03.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var bestFilms: FilmData?
    @State var awaitFilms: FilmData?
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor:  UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                filmScrollView(for: TopFilmTypes.best.rawValue, films: bestFilms?.films) { filmData in
                    self.bestFilms = filmData
                }
                filmScrollView(for: TopFilmTypes.await.rawValue, films: awaitFilms?.films) { filmData in
                    self.awaitFilms = filmData
                }
            }
            .background(Color(red: 45/255, green: 39/255, blue: 52/255))
            .navigationBarTitle("Movie Library", displayMode: .large)
        }
    }
    
    private func filmScrollView(for list: String, films: [MovieItem]?, onLoad: @escaping (FilmData) -> Void) -> some View {
        if let films = films {
            return AnyView(FilmsScrollView(films: films))
        } else {
            return AnyView(ProgressView().onAppear {
                FilmLoader().loadData(list: list, completion: { (filmData: FilmData?) in
                    guard let filmData = filmData else {
                        print("Could not read data")
                        return
                    }
                    onLoad(filmData)
                }, isOneMovie: false)
            })
        }
    }

    
//    private func loadingView(list: String, completion: @escaping (FilmData?) -> Void) -> some View {
//        ProgressView()
//            .onAppear {
//                FilmLoader().loadData(list: list, completion: completion, isOneMovie: false)
//            }
//    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
