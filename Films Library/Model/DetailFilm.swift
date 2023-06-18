struct DetailFilm: Codable{
    let kinopoiskId: Int
    let nameRu: String?
    let nameEn: String?
    let nameOriginal: String?
    let posterUrl: String?
    let posterUrlPreview: String?
    let genres: [Genre]?
    let ratingKinopoisk: Float?
    let webUrl: String?
    let year : Int?
    let filmLength: Int?
    let description: String?
}


struct Genre: Codable{
    let genre: String?
}
