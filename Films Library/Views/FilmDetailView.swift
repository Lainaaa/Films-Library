import SwiftUI
import SDWebImageSwiftUI

// TODO: Setup screen

struct FilmDetailView: View {
    var id: String
    let urlIfImageNil = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.computerhope.com%2Fjargon%2Fe%2Ferror.htm&psig=AOvVaw1WizU1o4E8-DUgTGxYzmbn&ust=1678369316020000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLi26Yi7zP0CFQAAAAAdAAAAABAE"
    @State var film: DetailFilm?
    
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
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 45/255, green: 39/255, blue: 52/255), Color.clear]), startPoint: .bottom, endPoint: .top)
                            )
                        Text(film.nameEn ?? film.nameOriginal ?? film.nameRu ?? "Error")
                            .foregroundColor(Color.white)
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
                        .foregroundColor(Color.white)
                        Spacer()
                        HStack{
                            if let rating = film.ratingKinopoisk{
                                Text("\(String(describing: rating))")
                                    .foregroundColor(Color.yellow)
                                    .font(.body)
                                RatingView(rating: rating)
                            }
                        }
                        Spacer()
                        Text(film.description ?? "")
                            .frame(alignment: .leading)
                        Button(action: {
                            guard let url = URL(string: film.webUrl!) else { return }
                            UIApplication.shared.open(url)
                        }) {
                            Text("Watch now")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    } else {
                        ProgressView()
                    }
                }
                .foregroundColor(Color.white)
                //                .background(Color(red: 45/255, green: 39/255, blue: 52/255))
                .onAppear {
                    // Make a request to load the film details
                    FilmLoader().loadFilm(id: id) { detailFilm in
                        if let film = detailFilm {
                            // use the loaded film object here
                            self.film = film
                        } else {
                            // handle error case here
                            print("Failed to load film")
                        }
                    }
                }
            }
        }
        .background(Color(red: 45/255, green: 39/255, blue: 52/255))
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(id: String(301))
    }
}
