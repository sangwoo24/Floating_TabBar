//
//  PageCell.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/09.
//

import UIKit

class PageCell: UICollectionViewCell {

    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "메롱"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
