//
//  MainViewController.swift
//  WhiteAndFluffy
//
//  Created by Alexander Grishin on 09.02.2022.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        print("hhh")
        let label = UILabel()
        label.text = "ggg"
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.textColor = .white
        
        self.view.addSubview(label)
        setup()
    }
    
    func setup() {
        viewControllers = [
            vcForTabBar(SearchController.speciman(), icon: UIImage(systemName: "house")!),
            vcForTabBar(LikeController.speciman(), icon: UIImage(systemName: "person")!),
        ]
    }
    
    func vcForTabBar(_ controller: UIViewController, icon: UIImage, title: String = "") -> UIViewController {
        let vc = controller
        vc.tabBarItem.image = icon
        if !title.isEmpty { vc.tabBarItem.title = title }
        return vc
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
