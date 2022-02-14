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

}
