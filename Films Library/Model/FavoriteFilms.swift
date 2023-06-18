//
//  FavoriteFilms.swift
//  Films Library
//
//  Created by Dmitrij Meidus on 13.06.23.
//

import SwiftData
import Foundation

@Model
class FavoriteFilms: Identifiable, Hashable{
    var id: UUID
    @Attribute(.unique) var kinopoiskId: Int
    var webUrl: String?
    var posterUrlPreview: String?
    var nameRu: String?
    var nameEn: String?
    var nameOriginal: String?
    // "description" name is reserved by SwiftData
    var descriptionOfFilm: String?
    
    init(id: UUID, kinopoiskId: Int, webUrl: String? = nil, posterUrlPreview: String? = nil, nameRu: String? = nil, nameEn: String? = nil, nameOriginal: String? = nil, descriptionOfFilm: String? = nil) {
        self.id = UUID()
        self.kinopoiskId = kinopoiskId
        self.webUrl = webUrl
        self.posterUrlPreview = posterUrlPreview
        self.nameRu = nameRu
        self.nameEn = nameEn
        self.nameOriginal = nameOriginal
        self.descriptionOfFilm = descriptionOfFilm
    }
}
