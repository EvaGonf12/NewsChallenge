
import UIKit

enum SessionAPIError: Error {
    case dataError
}

final class SessionAPI {

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    func send<T: APIRequest>(request: T, completion: @escaping(Result<T.Response, Error>) -> ()) {
        let request = request.requestWithBaseUrl()
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    do {
                        let str = String(decoding: data, as: UTF8.self)
                        let model = try JSONDecoder().decode(T.Response.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(model))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.dataError))
                    }
                }
            }
        }
        task.resume()
    }
    
}
