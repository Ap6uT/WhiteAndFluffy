//
//  ViewController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 09.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    class func speciman() -> ViewController {
        return ViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi ho ho")
        let label = UILabel()
        label.text = "123456"
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.textColor = .white
        
        self.view.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("hohoho")
    }


}
