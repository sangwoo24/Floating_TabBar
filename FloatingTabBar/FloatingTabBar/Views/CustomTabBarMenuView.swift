//
//  CustomTabBarMenuView.swift
//  FloatingTabBar
//
//  Created by 석상우 on 2021/08/10.
//

import UIKit

protocol CustomTabBarMenuDelegate: AnyObject {
    func tapMenu(to index: Int)
}

class CustomTabBarMenuView: UIView {
    
    // MARK: Properties
    var numberOfTabs: Int = 2
    
    weak var delegate: CustomTabBarMenuDelegate?
    var tabBarMenuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var tabBarIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var tabBarIndicatorViewLeadingConstraint: NSLayoutConstraint!
    var tabBarIndicatorViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setMenuView()
        setIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set View
    func setMenuView() {
        tabBarMenuCollectionView.delegate = self
        tabBarMenuCollectionView.dataSource = self
        tabBarMenuCollectionView.showsHorizontalScrollIndicator = false
        tabBarMenuCollectionView.register(TabBarMenuCell.self, forCellWithReuseIdentifier: TabBarMenuCell.reusableIdentifier)
        
        addSubview(tabBarMenuCollectionView)
        tabBarMenuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabBarMenuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tabBarMenuCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabBarMenuCollectionView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setIndicatorView() {
        addSubview(tabBarIndicatorView)
        tabBarIndicatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        tabBarIndicatorView.topAnchor.constraint(equalTo: tabBarMenuCollectionView.bottomAnchor).isActive = true
        tabBarIndicatorViewLeadingConstraint = tabBarIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        tabBarIndicatorViewLeadingConstraint.isActive = true
        tabBarIndicatorViewWidthConstraint = tabBarIndicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(numberOfTabs))
        tabBarIndicatorViewWidthConstraint.isActive = true
    }
}

// MARK: CollectionView
extension CustomTabBarMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfTabs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarMenuCell.reusableIdentifier, for: indexPath) as? TabBarMenuCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tapMenu(to: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / CGFloat(numberOfTabs), height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
