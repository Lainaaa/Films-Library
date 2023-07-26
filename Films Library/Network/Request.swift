import Foundation
import Alamofire

class FilmLoader {
    func loadListOfFilms(list: String) async throws -> FilmData {
        var urlParam: String
        urlParam = "top?type=\(list)&page=1"
        let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/" + urlParam)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
        }

        do {
            let decoder = JSONDecoder()
            let filmData = try decoder.decode(FilmData.self, from: data)
            return filmData
        } catch {
            throw error
        }
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
