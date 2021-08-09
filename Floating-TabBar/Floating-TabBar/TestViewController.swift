//
//  TestViewController.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/09.
//

import UIKit

class TestViewController: UIViewController {
    var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hello"
        label.textColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let label2 = UILabel()
        label2.textColor = .yellow
        label2.text = "ssibal"
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label2)
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        label2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Do any additional setup after loading the view.
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
