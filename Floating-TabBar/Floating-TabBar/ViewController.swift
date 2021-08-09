//
//  ViewController.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Test
        let firstController = createTabBarItem(title: "First", controller: FirstViewController())
        let secondController = createTabBarItem(title: "Second", controller: SecondViewController())
        let thirdController = createTabBarItem(title: "Third", controller: ThirdController())
        let forthController = createTabBarItem(title: "forth", controller: ForthController())
        
        let customTabBarView = CustomTabBarView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        customTabBarView.viewControllers = [FirstViewController(), SecondViewController(), ThirdController(), ForthController()]
//        customTabBarView.viewControllers = [firstController, secondController, thirdController, forthController]
//        customTabBarView.viewControllers = [TestViewController(), TestViewController(),TestViewController(),TestViewController()]
        
        view.addSubview(customTabBarView)
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customTabBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func createTabBarItem(title: String, controller: UIViewController) -> UIViewController {
        controller.title = title
        return controller
    }
}


