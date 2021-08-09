//
//  CustomCell.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/07.
//

import UIKit

class CustomCell: UICollectionViewCell {

    var label: UILabel = {
        let label = UILabel()
        label.text = "Tab"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }
    
    func setLabel() {
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
