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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("hohoho")
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
