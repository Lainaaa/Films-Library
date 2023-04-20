import Foundation

struct FilmData: Codable{
    var pagesCount: Int
    var films: [MovieItem]
    
    enum CodingKeys: String, CodingKey {
        case pagesCount
        case films
    }

}

struct MovieItem: Codable, Identifiable{
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrlPreview: String?
    var year : String?
    var id: Int { filmId }
}

struct Genre: Codable{
    var genre: String?
}

struct Film: Codable{
    var kinopoiskId: Int
    var nameRu: String?
    var nameEn: String?
    var nameOriginal: String?
    var posterUrl: String?
    var genres: [Genre]?
    var ratingKinopoisk: Float?
    var webUr: String?
    var year : Int?
    var filmLength: Int?
    var description: String?
}
