//
//  ViewController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 09.02.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 160, height: 160)
        // layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collection.backgroundColor = UIColor.white
        
        view.addSubview(collection)
        return collection
    }()
    
    var photos = Photos()
    
    class func speciman() -> ViewController {
        return ViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi ho ho")
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        photos.getRandom(completion: { [weak self] _ in
            self?.collectionView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("hohoho")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else {fatalError("Unabel to create cell")}
        cell.image.kf.setImage(with: URL(string: photos.content[indexPath.row].urls?.small ?? ""))
          
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

class CollectionCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 110))
        addSubview(img)
        return img
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
}
