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
    
    public typealias SuccessHandler = (_ photos: [PhotoInfo]) -> Void

    public typealias FailureHandler = (_ error: Error) -> Void
    
    public func request (_ endpoint: String,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters = [:],
                                        success: SuccessHandler?,
                                        failure: FailureHandler?) {

        let urlRequest = buildURLRequest(endpoint, method: method, parameters: parameters)

        urlSession.dataTask(with: urlRequest) { data, _, error in
            if let data = data {
                print(NSString(data: data, encoding:String.Encoding.utf8.rawValue)!)
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try jsonDecoder.decode([PhotoInfo].self, from: data)
                        DispatchQueue.main.async {
                            success?(result)
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            print("******* error message")
                            failure?(error)
                            //failure?(Error.decoding(message: error.localizedDescription))
                        }
                    }
                }
            } else if let error = error {
                failure?(error)
            }
        }.resume()
        
    }
    

    
    private func buildURLRequest(_ endpoint: String, method: HTTPMethod, parameters: Parameters) -> URLRequest {
        let url = URL(string: API.baseURL + endpoint)!.appendingQueryParameters(["client_id": accessKey])

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        switch method {
        case .get, .delete:
            urlRequest.url?.appendQueryParameters(parameters)
        case .post:
            urlRequest.httpBody = Data(parameters: parameters)
        }
        print(urlRequest)
        return urlRequest
    
    }

}
