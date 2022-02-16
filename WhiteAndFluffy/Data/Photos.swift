//
//  Photos.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 12.02.2022.
//

import UIKit


class Photos {
    
    let unsplash = Unsplash.shared
    
    private var dataTask: URLSessionDataTask?
    private var imageTask: URLSessionDownloadTask?
    
    private var content = [PhotoInfo]()
    var count: Int { content.count }
    
    private var totalPages = 1
    
    func getPhoto(by index: Int) -> PhotoInfo? {
        if index < count && index >= 0 {
            return content[index]
        }
        return nil
    }
    
    private var currentPage: Int = 0
    
    func clean() {
        totalPages = 1
        currentPage = 0
        content = []
    }
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var isLoading =  false
    
    func getRandom(completion: @escaping (Bool) -> Void) {
        isLoading = true
        unsplash.randomPhotos(success: { data, totalPages in
            self.content += data
            completion(true)
            self.isLoading = false
        }, failure: { error in
            print(error)
            completion(false)
            self.isLoading = false
        })
    }
    
    func getSearch(by keyword: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        let nextPage = currentPage + 1
        if nextPage <= totalPages {
            unsplash.searchPhotos(keyword: keyword, page: nextPage, success: { data, totalPages in
                self.content += data
                self.totalPages = totalPages
                completion(true)
                self.isLoading = false
                self.currentPage += 1
            }, failure: { error in
                print(error)
                completion(false)
                self.isLoading = false
            })
        }
    }
    
    func getLiked(completion: @escaping (Bool) -> Void) {
        isLoading = true
        unsplash.likedPhotos(success: { data, totalPages in
            self.content += data
            completion(true)
            self.isLoading = false
        }, failure: { error in
            print(error)
            completion(false)
            self.isLoading = false
        })
    }
    
    class func setLike(_ like: Bool, for id: String, completion: @escaping (Bool) -> Void) {
        let unsplash = Unsplash.shared
        unsplash.like(id, like: like, success: { _, _ in
            completion(true)
        }, failure: { _ in
            completion(false)
        })
    }

    class func getPhoto(by id: String, completion: @escaping (PhotoInfo?) -> Void) {
        let unsplash = Unsplash.shared
        unsplash.singlePhoto(id, success: { data, totalPages in
            if !data.isEmpty {
                completion(data.first)
            } else {
                completion(nil)
            }
        }, failure: { _ in
            completion(nil)
        })
    }
}

