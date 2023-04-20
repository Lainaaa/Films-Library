import SwiftUI
import SDWebImageSwiftUI

struct FilmsScrollView: View {
    let films: [MovieItem]
    let urlIfImageNil = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.computerhope.com%2Fjargon%2Fe%2Ferror.htm&psig=AOvVaw1WizU1o4E8-DUgTGxYzmbn&ust=1678369316020000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLi26Yi7zP0CFQAAAAAdAAAAABAE"
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(films) { film in
                    Spacer()
                    NavigationLink(destination: FilmDetailView(id: String(film.filmId))){
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: film.posterUrlPreview ?? urlIfImageNil))
                                .resizable()
                                .frame(width: 150,height: 200)
                                .cornerRadius(10)
                            Text(film.nameEn ?? film.nameRu ?? "error")
                                .foregroundColor(Color.white)
                                .font(.title2)
                                .frame(width: 150, height: 25)
                            Text(film.year ?? "error")
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
            }
        }
    }
}
