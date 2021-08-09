//
//  FirstViewController.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/07.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("init")
        view.backgroundColor = .red
        let v = UIView(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        v.backgroundColor = .yellow
        v.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(v)
        
        v.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        v.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        print(self.view.frame)
    }
}
