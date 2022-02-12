//
//  ViewTableController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 09.02.2022.
//

import UIKit
import Kingfisher

class ViewTableController: UIViewController {
    
    let photos = Photos()
    
    class func speciman() -> ViewTableController {
        return ViewTableController()
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .red
        table.frame = self.view.frame
        view.addSubview(table)
        return table
    }()
    
    var arr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("table")
        
        
        arr = ["cat", "cat smaller", "a little cat", "жесть"]
        
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        photos.getRandom(completion: { [weak self] success in
            self?.tableView.reloadData()
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("tableaaa")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewTableController: UITableViewDelegate, UITableViewDataSource {
     
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return photos.content.count
     }
     
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Cell else {fatalError("Unabel to create cell")}
       cell.label.text = ""
       cell.image.kf.setImage(with: URL(string: photos.content[indexPath.row].urls?.small ?? ""))
         
       return cell
     }
     
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
     }
}



class Cell: UITableViewCell {
    
    lazy var backView: UIView = {
       let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 110))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var label: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 42, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 110))
        return img
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(label)
        backView.addSubview(image)
    }

}
