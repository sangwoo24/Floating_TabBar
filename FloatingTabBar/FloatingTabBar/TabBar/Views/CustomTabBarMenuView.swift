//
//  CustomTabBarMenuView.swift
//  N-Split-Bill
//
//  Created by 석상우 on 2021/08/19.
//

import UIKit

protocol CustomTabBarMenuDelegate: AnyObject {
    func tapMenu(to index: Int)
}

class CustomTabBarMenuView: UIView {
    
    // MARK: Properties
    var numberOfTabs: Int = 2
    var tabBarViewControllers: [UIViewController]? {
        didSet {
            tabBarMenuCollectionView.reloadData()
        }
    }
    var tabBarMenuTextColor: UIColor? {
        didSet {
            tabBarMenuCollectionView.reloadData()
        }
    }
    var tabBarIndicatorBackgroundColor: UIColor? {
        willSet(indicatorBackgroundColor) {
            tabBarIndicatorView.backgroundColor = indicatorBackgroundColor
        }
    }
    
    weak var delegate: CustomTabBarMenuDelegate?
    var tabBarMenuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var tabBarIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var tabBarIndicatorViewLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var tabBarIndicatorViewWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK:  Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setMenuView()
        setIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tabBarIndicatorViewWidthConstraint.constant = frame.width / CGFloat(numberOfTabs)
    }
    
    // MARK: Set View
    func setMenuView() {
        tabBarMenuCollectionView.delegate = self
        tabBarMenuCollectionView.dataSource = self
        tabBarMenuCollectionView.register(TabBarMenuCell.self, forCellWithReuseIdentifier: TabBarMenuCell.reusableIdentifier)
        
        addSubview(tabBarMenuCollectionView)
        NSLayoutConstraint.activate([
            tabBarMenuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBarMenuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabBarMenuCollectionView.topAnchor.constraint(equalTo: topAnchor),
            tabBarMenuCollectionView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setIndicatorView() {
        addSubview(tabBarIndicatorView)
        
        tabBarIndicatorViewWidthConstraint = tabBarIndicatorView.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(numberOfTabs))
        tabBarIndicatorViewLeadingConstraint = tabBarIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        NSLayoutConstraint.activate([
            tabBarIndicatorView.heightAnchor.constraint(equalToConstant: 5),
            tabBarIndicatorView.topAnchor.constraint(equalTo: tabBarMenuCollectionView.bottomAnchor),
            tabBarIndicatorViewLeadingConstraint,
            tabBarIndicatorViewWidthConstraint
        ])
    }
}

// MARK:- UICollectionViewDelegate
extension CustomTabBarMenuView: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tapMenu(to: indexPath.item)
    }
}

// MARK:- UICollectionViewDataSource
extension CustomTabBarMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfTabs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarMenuCell.reusableIdentifier, for: indexPath) as? TabBarMenuCell else { return UICollectionViewCell() }
        
        if let title = tabBarViewControllers?[indexPath.item].title {
            cell.label.text = title
        }
        
        if let textColor = tabBarMenuTextColor {
            cell.label.textColor = textColor
        }
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension CustomTabBarMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(numberOfTabs), height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

