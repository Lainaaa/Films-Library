import Foundation

class FilmLoader {
    func loadData<T: Codable>(list: String, completion: @escaping (T?) -> Void, isOneMovie: Bool) {
        var urlParam: String
        if isOneMovie{
            urlParam = list
        }else{
            urlParam = "top?type=\(list)&page=1"
        }
        let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/" + urlParam)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, response == response else {
                print(error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                    let filmData = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(filmData)
                    }
            } catch {
                print(error)
                completion(nil)
            }
        }

        task.resume()
    }
}
