//
//  CustomTabBarHeaderView.swift
//  FloatingTabBar
//
//  Created by 석상우 on 2021/08/10.
//

import UIKit

class CustomTabBarHeaderView: UIView {
    
    // MARK: Properties
    var headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    var headerSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "SubTitle"
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        setHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderView() {
        addSubview(headerSubTitle)
        headerSubTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        headerSubTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        addSubview(headerTitle)
        headerTitle.leadingAnchor.constraint(equalTo: headerSubTitle.leadingAnchor).isActive = true
        headerTitle.bottomAnchor.constraint(equalTo: headerSubTitle.topAnchor, constant: -10).isActive = true
    }
}
