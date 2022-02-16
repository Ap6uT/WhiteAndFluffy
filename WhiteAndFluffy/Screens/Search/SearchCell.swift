//
//  SearchCell.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 16.02.2022.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        img.contentMode = .scaleAspectFit
        addSubview(img)
        return img
    }()

    func setup(for photo: PhotoInfo?) {
        image.kf.setImage(with: URL(string: photo?.urls?.small ?? ""))
    }
}
