import Foundation

struct FilmData: Codable{
    let pagesCount: Int
    let films: [MovieItem]
    
    enum CodingKeys: String, CodingKey {
        case pagesCount
        case films
    }
}

struct MovieItem: Codable, Identifiable{
    let filmId: Int
    let nameRu: String?
    let nameEn: String?
    let posterUrlPreview: String?
    let year : String?
    var id: Int { filmId }
}
