import Foundation
import Alamofire

class FilmLoader {
    func loadListOfFilms(list: String, completion: @escaping (FilmData) -> Void) {
        var urlParam: String
            urlParam = "top?type=\(list)&page=1"
        let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/" + urlParam)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response == response else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let filmData = try decoder.decode(FilmData.self, from: data)
                DispatchQueue.main.async {
                    completion(filmData) // Call completion closure with filmData
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
    
    func loadFilm(id: String, completion: @escaping (DetailFilm?) -> Void) {
        let url = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)"
        let headers: HTTPHeaders = [
            "X-API-KEY": apiKey,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: DetailFilm.self) { response in
            switch response.result {
            case .success(let detailFilm):
                completion(detailFilm)
            case .failure(let error):
                print("Error loading film: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
