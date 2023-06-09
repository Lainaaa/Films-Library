struct DetailFilm: Codable{
    var kinopoiskId: Int
    var nameRu: String?
    var nameEn: String?
    var nameOriginal: String?
    var posterUrl: String?
    var genres: [Genre]?
    var ratingKinopoisk: Float?
    var webUrl: String?
    var year : Int?
    var filmLength: Int?
    var description: String?
}


struct Genre: Codable{
    var genre: String?
}
