//
//  CustomTabBar.swift
//  Floating-TabBar
//
//  Created by 석상우 on 2021/08/06.
//

import UIKit

class CustomTabBarView: UIView {
    
    // MARK: Properties
    private let cellId: String = "tabBarCell"
    private let cellId2: String = "pageCell"
    
    var indicatorBarColor: UIColor = .black
    var tabBarBackgroundColor: UIColor = .white
    var numberOfTabs: Int = 2
    
    var viewControllers: [UIViewController]? {
        didSet {
            if let controllers = viewControllers {
                numberOfTabs = controllers.count
            }
            tabBarIndicatorViewWidthConstraint.isActive = false
            tabBarIndicatorViewWidthConstraint = tabBarIndicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(numberOfTabs))
            tabBarIndicatorViewWidthConstraint.isActive = true
            tabBarCollectionView.reloadData()
        }
    }
    
    var tabBarIndicatorViewLeadingConstraint: NSLayoutConstraint!
    var tabBarIndicatorViewWidthConstraint: NSLayoutConstraint!
    
    lazy var tabBarCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = self.tabBarBackgroundColor
        return collectionView
    }()
    
    lazy var tabBarIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = self.indicatorBarColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tabBarPageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: Init view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTabBarCollectionView()
        setTabBarIndicatorView()
        setTabBarPageCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup View
    func setTabBarCollectionView() {
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.showsHorizontalScrollIndicator = false
        tabBarCollectionView.register(TabBarCell.self, forCellWithReuseIdentifier: cellId)
        
        self.addSubview(tabBarCollectionView)
        tabBarCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tabBarCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tabBarCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tabBarCollectionView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setTabBarIndicatorView() {
        self.addSubview(tabBarIndicatorView)
        tabBarIndicatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        tabBarIndicatorView.topAnchor.constraint(equalTo: tabBarCollectionView.bottomAnchor).isActive = true
        tabBarIndicatorViewLeadingConstraint = tabBarIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        tabBarIndicatorViewLeadingConstraint.isActive = true
        tabBarIndicatorViewWidthConstraint = tabBarIndicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(numberOfTabs))
        tabBarIndicatorViewWidthConstraint.isActive = true
    }
    
    func setTabBarPageCollectionView() {
        tabBarPageCollectionView.delegate = self
        tabBarPageCollectionView.dataSource = self
        tabBarPageCollectionView.showsHorizontalScrollIndicator = false
        tabBarPageCollectionView.isScrollEnabled = false
        tabBarPageCollectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId2)
        
        self.addSubview(tabBarPageCollectionView)
        tabBarPageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tabBarPageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tabBarPageCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tabBarPageCollectionView.topAnchor.constraint(equalTo: tabBarIndicatorView.bottomAnchor).isActive = true
    }
}

// MARK: CollectionView
extension CustomTabBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfTabs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabBarCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? TabBarCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as? PageCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.tabBarCollectionView {
            return CGSize(width: self.frame.width / CGFloat(numberOfTabs) , height: 55)
        } else {
            return CGSize(width: self.tabBarPageCollectionView.frame.width, height: self.tabBarPageCollectionView.frame.height)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.tabBarCollectionView {
            self.tabBarPageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabBarIndicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / CGFloat(numberOfTabs)
    }
}
