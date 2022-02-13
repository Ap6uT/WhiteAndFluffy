//
//  Unsplash+ Search.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 13.02.2022.
//

import Foundation

extension Unsplash {
    func searchPhotos(keyword: String, page: Int, success: SuccessHandler?, failure: FailureHandler? = nil) {
        request("search/photos", parameters: ["query": keyword, "page": page, "per_page": 30], success: success, failure: failure)
    }
}
