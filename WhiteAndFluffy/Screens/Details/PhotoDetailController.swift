//
//  PhotoDetailController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 14.02.2022.
//

import UIKit

class PhotoDetailController: UIViewController {
    
    class func speciman(data: Any?, delegate: PhotoDetailControllerDelegate? = nil) -> PhotoDetailController {
        let vc = PhotoDetailController()
        vc.photo = data as? PhotoInfo
        vc.delegate = delegate
        return vc
    }
    
    private var photo: PhotoInfo?
    private var delegate: PhotoDetailControllerDelegate?

    lazy private var image: UIImageView = {
        var leftAnchor: CGFloat = 10
        var photoWidth = view.frame.width - 20
        var photoHeight = photoWidth
        if let photo = photo, let width = photo.width, let height = photo.height {
            photoHeight = photoWidth * CGFloat(height) / CGFloat(width)
            if photoHeight > view.frame.height - 250 {
                photoHeight = view.frame.height - 250
                photoWidth = photoHeight * CGFloat(width) / CGFloat(height)
                leftAnchor = (view.frame.width - photoWidth) / 2
            }
        } else {
            photoHeight = view.frame.width - 20
        }
        let img = UIImageView(frame: CGRect(x: leftAnchor, y: 10, width: photoWidth, height: photoHeight))
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        return img
    }()
    
    lazy private var nameLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 35, y: view.frame.height - 240, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var dateLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 35, y: view.frame.height - 220, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var placeLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 35, y: view.frame.height - 200, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var downloadCountLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 35, y: view.frame.height - 180, width: view.frame.width - 40, height: 30))
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        view.addSubview(lbl)
        return lbl
    }()
    
    lazy private var likeButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 40, y: view.frame.height - 140, width: view.frame.width - 80, height: 40))
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btn.backgroundColor = .lightGray
        view.addSubview(btn)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPhoto()
        setup()
        if let id = photo?.id {
            Photos.getPhoto(by: id, completion: { [weak self] photo in
                if let photo = photo {
                    self?.photo = photo
                    self?.setup()
                }
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let photo = photo, photo.liked == false {
            delegate?.needDeletePhoto(photo)
        }
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
    
    func setupPhoto() {
        if let photo = photo {
            image.kf.indicatorType = .activity
            image.kf.setImage(with: URL(string: photo.urls?.full ?? ""))
        }
    }

    func setup() {
        if let photo = photo {
            nameLabel.text = photo.user?.name ?? "Unknown User"
            let locationName: String
            if let country = photo.location?.country, let city = photo.location?.city {
                locationName = "\(country), " + city
            } else {
                locationName = ""
            }
            placeLabel.text = locationName
            downloadCountLabel.text = "Downloads: \(photo.downloads ?? 0)"
            buttonTitleToggle()
        }
    }

}

protocol PhotoDetailControllerDelegate {
    func needDeletePhoto(_ photo: PhotoInfo)
}
