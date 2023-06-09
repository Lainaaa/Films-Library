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
