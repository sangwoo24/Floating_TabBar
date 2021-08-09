//
//  TabBarCell.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/07.
//

import UIKit

class TabBarCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
//    override var isSelected: Bool {
//        didSet{
//            print("Changed")
//            self.label.textColor = isSelected ? .black : .lightGray
//        }
//    }
}
