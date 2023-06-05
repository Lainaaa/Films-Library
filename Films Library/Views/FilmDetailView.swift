import SwiftUI
import SDWebImageSwiftUI

// TODO: Setup screen

struct FilmDetailView: View {
    var id: String
    let urlIfImageNil = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.computerhope.com%2Fjargon%2Fe%2Ferror.htm&psig=AOvVaw1WizU1o4E8-DUgTGxYzmbn&ust=1678369316020000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLi26Yi7zP0CFQAAAAAdAAAAABAE"
    @State var film: DetailFilm?
    
    var body: some View {
        VStack {
            if let film = film {
                // Display film details here
                WebImage(url: URL(string: film.posterUrl ?? urlIfImageNil))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)              .scaledToFit()
                Text(film.nameEn ?? film.nameOriginal ?? film.nameRu ?? "Error")
                    .foregroundColor(Color.white)
                    .offset(y: -50)
                    .padding(.bottom, -50)
                    .font(.title)
                    .fontWeight(.bold)
                Text(String((film.year)!) ?? "Error")
                    .foregroundColor(Color.white)
//                HStack{
//                    Text("\(film.nameRu)")
//                }
            } else {
                Text("Loading")
                ProgressView()
            }
        }
        .background(Color(red: 45/255, green: 39/255, blue: 52/255))
        // TODO: - rewrite this code
//        .onAppear {
//            // Make a request to load the film details
//            FilmLoader().loadData(list: "\(id)", completion: { (filmData: DetailFilm?) in
//                self.film = filmData
//            }, isOneMovie: true)
//        }
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(id: String(301))
    }
}
