//
//  Unsplash+Random.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 12.02.2022.
//

import Foundation

extension Unsplash {
    func randomPhotos(success: SuccessHandler<[PhotoInfo]>?, failure: FailureHandler? = nil) {
        request("photos/random", parameters: ["count": 30], success: success, failure: failure)
    }
}
