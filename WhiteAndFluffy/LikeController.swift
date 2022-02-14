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
        view.addSubview(table)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        photos.getRandom(completion: { [weak self] success in
            self?.tableView.reloadData()
        })
    }

}

extension LikeController: UITableViewDelegate, UITableViewDataSource {
     
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return photos.count
     }
     
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell else {fatalError("Unabel to create cell")}
       cell.setup(for: photos.getPhoto(by: indexPath.row))
       return cell
     }
     
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
     }
}



class Cell: UITableViewCell {
    
    lazy var label: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 120, y: 45, width: self.frame.width - 130, height: 30))
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        addSubview(lbl)
        return lbl
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        addSubview(img)
        return img
    }()
    
    func setup(for photo: PhotoInfo?) {
        label.text = photo?.user?.name ?? "Unknown User"
        image.kf.setImage(with: URL(string: photo?.urls?.small ?? ""))
    }

}
