//
//  PhotoInfo.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 12.02.2022.
//

import Foundation

public struct PhotoInfo: Codable {
    public let id: String?
    public let liked: Bool?
    public let urls: PhotoURLs?
    
    enum CodingKeys: String, CodingKey {
        case liked = "liked_by_user"
        case id, urls
    }
}
