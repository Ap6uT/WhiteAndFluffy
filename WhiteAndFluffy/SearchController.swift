//
//  ViewController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 09.02.2022.
//

import UIKit
import SwiftUI

class SearchController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 160, height: 160)

        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collection.backgroundColor = UIColor.white
        
        view.addSubview(collection)
        return collection
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        search.delegate = self
        search.tintColor = .white
        search.barTintColor = .gray
        search.barStyle = .default
        search.enablesReturnKeyAutomatically = false
        search.sizeToFit()
        return search
    }()
    
    private let customRefreshControl = UIRefreshControl()
    
    private var photos = Photos()
    private var searchWord: String = "cats" {
        didSet {
            photos.clean()
        }
    }
    
    class func speciman() -> SearchController {
        return SearchController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        getPhotos()
        
        customRefreshControl.addTarget(self, action: #selector(loadClean(_:)), for: .valueChanged)
        collectionView.refreshControl = customRefreshControl
        
        

    }
    
    @objc private func loadClean(_ sender: Any) {
        photos.clean()
        getPhotos()
    }
    
    private func getPhotos() {
        if searchWord == "" {
            photos.getRandom(completion: { [weak self] _ in
                self?.collectionView.reloadData()
            })
        } else {
            photos.getSearch(by: searchWord, completion: { [weak self] _ in
                self?.collectionView.reloadData()
            })
        }
    }
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else {fatalError("Unabel to create cell")}
        cell.image.kf.setImage(with: URL(string: photos.getPhoto(by: indexPath.row)?.urls?.small ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == photos.count - 1 {
            if !photos.isLoading {
                getPhotos()
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWord = searchBar.text ?? ""
        getPhotos()
    }
}

class CollectionCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        img.contentMode = .scaleAspectFit
        addSubview(img)
        return img
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
}
