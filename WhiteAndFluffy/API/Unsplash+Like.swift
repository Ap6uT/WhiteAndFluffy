//
//  Unsplash+Like.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 14.02.2022.
//

import Foundation

extension Unsplash {
    func likedPhotos(success: SuccessHandler?, failure: FailureHandler? = nil) {
        request("users/ap6ut/likes", parameters: ["per_page": 50], success: success, failure: failure)
    }
    
    func like(_ id: String, success: SuccessHandler?, failure: FailureHandler? = nil) {
        request("photos/\(id)/like", method: .post, success: success, failure: failure)
    }
    
    func unlike(_ id: String, success: SuccessHandler?, failure: FailureHandler? = nil) {
        request("photos/\(id)/like", method: .delete, success: success, failure: failure)
    }
}
