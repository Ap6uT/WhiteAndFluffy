//
//  Unsplash.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 12.02.2022.
//

import UIKit

public class Unsplash {
    
    
    public static let shared = Unsplash()

    private init() {
    }
    
    private let urlSession = URLSession(configuration: .default)
    
    private enum API {
         static let baseURL = "https://api.unsplash.com/"
     }

    public enum HTTPMethod: String {
        case get = "GET", post = "POST", delete = "DELETE"
    }
    
    typealias SuccessHandler = (_ photos: [PhotoInfo], _ pagesCount: Int) -> Void

    typealias FailureHandler = (_ error: Error?) -> Void
    
    func request (_ endpoint: String,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters = [:],
                                        success: SuccessHandler?,
                                        failure: FailureHandler?) {

        let urlRequest = buildURLRequest(endpoint, method: method, parameters: parameters)

        urlSession.dataTask(with: urlRequest) { data, _, error in
            if let data = data {
                DispatchQueue.global(qos: .utility).async {
                    let jsonDecoder = JSONDecoder()
                    if let result = try? jsonDecoder.decode([PhotoInfo].self, from: data) {
                        DispatchQueue.main.async {
                            success?(result, 0)
                        }
                        return
                    }
                    if let result = try? jsonDecoder.decode(PhotoPages.self, from: data) {
                        DispatchQueue.main.async {
                            success?(result.results ?? [], result.totalPages ?? 0)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        failure?(error)
                    }
                }
            } else if let error = error {
                failure?(error)
            }
        }.resume()
        
    }
    
    private func buildURLRequest(_ endpoint: String, method: HTTPMethod, parameters: Parameters) -> URLRequest {
        let url = URL(string: API.baseURL + endpoint)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.setValue("Bearer \(auth)", forHTTPHeaderField:"Authorization")
        switch method {
        case .get, .delete:
            urlRequest.url?.appendQueryParameters(parameters)
        case .post:
            urlRequest.httpBody = Data(parameters: parameters)
        }

        return urlRequest
    
    }

}
