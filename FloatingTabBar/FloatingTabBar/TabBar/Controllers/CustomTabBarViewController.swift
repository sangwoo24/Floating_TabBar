//
//  ViewController.swift
//  FloatingTabBar
//
//  Created by 석상우 on 2021/08/10.
//

import UIKit

class CustomTabBarViewController: UIViewController {
    
    // MARK: Properties
    var numberOfPages: Int = 2
    var tabBarViewControllers: [UIViewController]? {
        didSet {
            if let controller = tabBarViewControllers {
                numberOfPages = controller.count
                tabBarMenuView.numberOfTabs = numberOfPages
                tabBarMenuView.tabBarIndicatorViewWidthConstraint.constant = tabBarMenuView.frame.width / CGFloat(numberOfPages)
                tabBarMenuView.tabBarViewControllers = controller
            }
        }
    }
    var tabBarMenuTextColor: UIColor? {
        willSet(textColor) {
            tabBarMenuView.tabBarMenuTextColor = textColor
        }
    }
    var tabBarIndicatorBackgroundColor: UIColor? {
        willSet(backgroundColor) {
            tabBarMenuView.tabBarIndicatorBackgroundColor = backgroundColor
        }
    }
    
    var tabBarHeaderView = CustomTabBarHeaderView()
    lazy var tabBarMenuView = CustomTabBarMenuView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    var tabBarPageView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTabBarHeaderView()
        setTabBarMenuView()
        setTabBarPageView()
    }
    
    // MARK: SetView
    func setTabBarHeaderView() {
        tabBarHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tabBarHeaderView)
        tabBarHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarHeaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tabBarHeaderView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func setTabBarMenuView() {
        tabBarMenuView.delegate = self
        tabBarMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tabBarMenuView)
        tabBarMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarMenuView.topAnchor.constraint(equalTo: tabBarHeaderView.bottomAnchor, constant: 5).isActive = true
        tabBarMenuView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setTabBarPageView() {
        tabBarPageView.delegate = self
        tabBarPageView.dataSource = self
        tabBarPageView.isPagingEnabled = true
        tabBarPageView.isScrollEnabled = true
        tabBarPageView.showsHorizontalScrollIndicator = false
        tabBarPageView.register(TabBarPageCell.self, forCellWithReuseIdentifier: TabBarPageCell.reusableIdentifier)
        
        view.addSubview(tabBarPageView)
        tabBarPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabBarPageView.topAnchor.constraint(equalTo: tabBarMenuView.bottomAnchor).isActive = true
    }
}

// MARK: TabBarDelegate
extension CustomTabBarViewController: CustomTabBarMenuDelegate {
    func tapMenu(to index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tabBarPageView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: CollectionView
extension CustomTabBarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarPageCell.reusableIdentifier, for: indexPath) as? TabBarPageCell else { return UICollectionViewCell() }
        
        if let vc = self.tabBarViewControllers?[indexPath.item] {
            self.addChild(vc)
            cell.contentView.addSubview(vc.view!)
            vc.view.frame = cell.contentView.bounds
            vc.didMove(toParent: self)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tabBarPageView.frame.width, height: tabBarPageView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabBarMenuView.tabBarIndicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / CGFloat(numberOfPages)
    }
}
