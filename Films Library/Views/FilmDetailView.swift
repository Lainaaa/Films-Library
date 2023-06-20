import SwiftUI
import SDWebImageSwiftUI
import SwiftData

struct FilmDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var favorites: [FavoriteFilms]
    var id: String
    var isFavoriteFilm: Bool {
        for favorite in favorites {
            if String(favorite.kinopoiskId) == id {
                return true
            }
        }
        return false
    }
    let urlIfImageNil = "https://www.computerhope.com/jargon/e/error.png"
    @State private var film: DetailFilm?
    
    var body: some View {
        // to know size of screen
        GeometryReader{ reader in
            ScrollView{
                VStack {
                    if let film = film {
                        WebImage(url: URL(string: film.posterUrl ?? urlIfImageNil))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: reader.size.width, maxHeight: reader.size.height) .scaledToFit()
                            .cornerRadius(25)
                            .padding(.top, -40)
                        //Gradient
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 45/255, green: 39/255, blue: 52/255), Color.clear]), startPoint: .bottom, endPoint: .top)
                            )
                        Text(film.nameEn ?? film.nameOriginal ?? film.nameRu ?? "Error")
                            .foregroundStyle(Color.white)
                            .offset(y: -50)
                            .padding(.bottom, -50)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(film.nameRu ?? "" )
                            .padding(.top, -20)
                        Spacer()
                        HStack{
                            Text("\(film.year.map(String.init) ?? "")")
                            Text("✩")
                            Text(film.genres?.map({ $0.genre ?? "" }).joined(separator: ", ") ?? "")
                            Text("✩")
                            if let filmLength = film.filmLength {
                                let filmLengthInMinutes = filmLength / 60
                                Text("\(filmLengthInMinutes)h \(filmLength - filmLengthInMinutes * 60)m")
                            } else {
                                Text("")
                            }
                        }
                        .bold()
                        .foregroundStyle(Color.white)
                        Spacer()
                        HStack{
                            if let rating = film.ratingKinopoisk{
                                Text("\(String(describing: rating))")
                                    .foregroundStyle(Color.red)
                                    .font(.body)
                                RatingView(rating: rating)
                            }
                        }
                        Spacer()
                        Text(film.description ?? "")
                            .frame(alignment: .leading)
                        HStack{
                            Button(action: {
                                guard let url = URL(string: film.webUrl!) else { return }
                                UIApplication.shared.open(url)
                            }) {
                                Text(" Смотреть ")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            Button(action: {
                                if !isFavoriteFilm{
                                    addFavorite(kinopoiskId: film.kinopoiskId, webUrl: film.webUrl, posterUrlPreview: film.posterUrlPreview, nameRu: film.nameRu, nameEn: film.nameEn, nameOriginal: film.nameOriginal, descriptionOfFilm: film.description)
                                }else{
                                    deleteFavorite(id: film.kinopoiskId)
                                }
                            }) {
                                var text: String{
                                    if !isFavoriteFilm{
                                        return "В избранное"
                                    }else{
                                        return "Из избранного"
                                    }
                                }
                                Text(text)
                                    .font(.headline)
                                    .foregroundStyle(.red)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .foregroundStyle(Color.white)
                .onAppear {
                    FilmLoader().loadFilm(id: id) { detailFilm in
                        if let film = detailFilm {
                            self.film = film
                        } else {
                            print("Failed to load film")
                        }
                    }
                }
            }
        }
        .background(Color(red: 45/255, green: 39/255, blue: 52/255))
    }
    
    private func addFavorite(kinopoiskId: Int, webUrl: String?,  posterUrlPreview: String?,  nameRu: String?,  nameEn: String?,  nameOriginal: String?,  descriptionOfFilm: String?) {
        withAnimation {
            let newFavorite = FavoriteFilms(kinopoiskId: kinopoiskId, webUrl: webUrl, posterUrlPreview: posterUrlPreview, nameRu: nameRu, nameEn: nameEn, nameOriginal: nameOriginal, descriptionOfFilm: descriptionOfFilm)
            modelContext.insert(newFavorite)
            do {
                try modelContext.save()
            } catch {
                print("Error occurred while saving: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteFavorite(id: Int) {
        withAnimation {
            let f = favorites.first(where: {$0.kinopoiskId == id})
            modelContext.delete(f!)
            do {
                try modelContext.save()
            } catch {
                print("Error occurred while saving: \(error.localizedDescription)")
            }
        }
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(id: String(301))
    }
}
