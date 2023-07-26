//
//  Films_LibraryApp.swift
//  Films Library
//
//  Created by Dmitrij Meidus on 09.03.23.
//

import SwiftUI
import SwiftData

@main
struct Films_LibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteFilms.self)
    }
}
