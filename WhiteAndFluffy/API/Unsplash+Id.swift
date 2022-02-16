//
//  Unsplash+Id.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 16.02.2022.
//

import Foundation

extension Unsplash {
    func singlePhoto(_ id: String, success: SuccessHandler?, failure: FailureHandler? = nil) {
        request("photos/\(id)", success: success, failure: failure)
    }
}
