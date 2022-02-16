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
    let location: LocationType?
    let downloads: Int?
    
    enum LocationType : Codable {
        case string(String)
        case locationInfo(Location)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if let x = try? container.decode(Location.self) {
                self = .locationInfo(x)
                return
            }
            throw DecodingError.typeMismatch(LocationType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let x):
                try container.encode(x)
            case .locationInfo(let x):
                try container.encode(x)
            }
        }
    }
    
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
