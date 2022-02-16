//
//  LikeCell.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 16.02.2022.
//

import UIKit

class LikedCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 120, y: 45, width: self.frame.width - 130, height: 30))
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        addSubview(lbl)
        return lbl
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        img.contentMode = .scaleAspectFit
        addSubview(img)
        return img
    }()
    
    func setup(for photo: PhotoInfo?) {
        label.text = photo?.user?.name ?? "Unknown User"
        image.kf.setImage(with: URL(string: photo?.urls?.small ?? ""))
    }

}
