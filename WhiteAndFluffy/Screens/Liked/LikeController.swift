//
//  ViewTableController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 09.02.2022.
//

import UIKit
import Kingfisher

class LikeController: UIViewController {
    
    let photos = Photos()
    
    class func speciman() -> LikeController {
        return LikeController()
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.frame = self.view.frame
        table.register(LikedCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(table)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photos.clean()
        photos.getLiked(completion: { [weak self] success in
            self?.tableView.reloadData()
            if self?.photos.count == 0 {
                let alert = UIAlertController(title: "Well", message: "You haven't liked anything yet", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        })
    }

}

extension LikeController: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? LikedCell else {fatalError("Unabel to create cell")}
        cell.setup(for: photos.getPhoto(by: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoDetailController.speciman(data: photos.getPhoto(by: indexPath.row), delegate: self)
        present(vc, animated: true, completion: nil)
    }
}

extension LikeController: PhotoDetailControllerDelegate {
    func needDeletePhoto(_ photo: PhotoInfo) {
        photos.remove(photo)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
