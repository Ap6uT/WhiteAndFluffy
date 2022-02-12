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
    
    var content = [PhotoInfo]()
    
    var currentPage: Int = 0
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var isLoading =  false
    
    func getRandom(completion: @escaping (Bool) -> Void) {
        isLoading = true
        // let nextPage = currentPage + 1
        unsplash.randomPhotos(success: { data in
            self.content += data
            completion(true)
            self.isLoading = false
        }, failure: { error in
            print(error)
            self.isLoading = false
        })
    }
    
    

}

