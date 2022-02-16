//
//  PhotoDetailController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 14.02.2022.
//

import UIKit

class PhotoDetailController: UIViewController {
    
    class func speciman(data: Any?) -> PhotoDetailController {
        let vc = PhotoDetailController()
        vc.photo =  data as? PhotoInfo
        return vc
    }
    
    private var photo: PhotoInfo?
    
    lazy private var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.width - 20))
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        return img
    }()
    
    lazy private var nameLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: view.frame.width + 10, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var dateLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: view.frame.width + 40, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var placeLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: view.frame.width + 60, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var downloadCountLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 20, y: view.frame.width + 80, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var likeButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 40, y: view.frame.width + 115, width: view.frame.width - 80, height: 40))
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btn.backgroundColor = .lightGray
        view.addSubview(btn)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    @objc func buttonAction(sender: UIButton!) {

        if let photo = photo, let liked = photo.liked {
            Photos.setLike(!liked, for: photo.id ?? "", completion: { [weak self] success in
                if success {
                    self?.photo?.liked = !liked
                    self?.buttonTitleToggle()
                }
            })
        }
    }
    
    func buttonTitleToggle() {
        let likeButtonText = (photo?.liked ?? false) ? "Unlike" : "Like"
        likeButton.setTitle(likeButtonText, for: .normal)
    }

    func setup() {
        if let photo = photo {
            image.kf.setImage(with: URL(string: photo.urls?.full ?? ""))
            nameLabel.text = photo.user?.name ?? "Unknown User"
            let locationText: String
            switch photo.location {
                case .string(let x): locationText = x
                case .locationInfo(let x): locationText = x.name ?? "Unknown Location"
                default: locationText = "Unknown Location"
            }
            placeLabel.text = locationText
            downloadCountLabel.text = "Downloads: \(photo.downloads ?? 0)"
            buttonTitleToggle()
        }
    }

}