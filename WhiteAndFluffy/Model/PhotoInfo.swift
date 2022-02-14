//
//  PhotoInfo.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 12.02.2022.
//

import Foundation

struct PhotoPages: Codable {
    let results: [PhotoInfo]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case results
    }
}

struct PhotoInfo: Codable {
    let id: String?
    let user: User?
    var liked: Bool?
    let urls: PhotoURLs?
    let location: Location?
    let downloads: Int?
    
    enum CodingKeys: String, CodingKey {
        case liked = "liked_by_user"
        case id, urls, user, location, downloads
    }
}

struct User: Codable {
    let name: String?
}

struct Location: Codable {
    let name: String?
}

struct PhotoURLs: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
}
