//
//  Unsplash+Random.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 12.02.2022.
//

import Foundation

extension Unsplash {
    public func randomPhotos(success: SuccessHandler?, failure: FailureHandler? = nil) {
        request("photos/random", parameters: ["count":30], success: success, failure: failure)
    }
}
