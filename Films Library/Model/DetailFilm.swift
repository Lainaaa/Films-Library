struct DetailFilm: Codable{
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
