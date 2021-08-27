//
//  CustomTabBarViewController.swift
//  N-Split-Bill
//
//  Created by 석상우 on 2021/08/19.
//

import UIKit

class CustomTabBarViewController: UIViewController {
    
    // MARK: Properties
    var numberOfPages: Int = 2
    var tabBarMenuViewTopAnchor = NSLayoutConstraint()
    var tabBarViewControllers: [UIViewController]? {
        didSet {
            if let controller = tabBarViewControllers {
                numberOfPages = controller.count
                tabBarMenuView.numberOfTabs = numberOfPages
                tabBarMenuView.tabBarIndicatorViewWidthConstraint.constant = tabBarMenuView.frame.width / CGFloat(numberOfPages)
                tabBarMenuView.tabBarViewControllers = controller
                tabBarMenuView.tabBarMenuCollectionView.reloadData()
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
    var tabBarHeaderView: UIView? {
        willSet(header) {
            if let previousHeaderView = tabBarHeaderView {
                previousHeaderView.removeFromSuperview()
            }
            guard let header = header else { return }
            setHeaderView(header: header)
        }
    }
    var tabBarMenuView = CustomTabBarMenuView()
    var tabBarPageView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTabBarMenuView()
        setTabBarPageView()
    }
    
    // MARK: - SetView
    func setTabBarMenuView() {
        tabBarMenuView.delegate = self
        tabBarMenuView.translatesAutoresizingMaskIntoConstraints = false
        tabBarMenuViewTopAnchor = tabBarMenuView.topAnchor.constraint(equalTo: view.topAnchor)

        view.addSubview(tabBarMenuView)
        NSLayoutConstraint.activate([
            tabBarMenuViewTopAnchor,
            tabBarMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarMenuView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setTabBarPageView() {
        tabBarPageView.delegate = self
        tabBarPageView.dataSource = self
        tabBarPageView.register(TabBarPageCell.self, forCellWithReuseIdentifier: TabBarPageCell.reusableIdentifier)
        
        view.addSubview(tabBarPageView)
        NSLayoutConstraint.activate([
            tabBarPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarPageView.topAnchor.constraint(equalTo: tabBarMenuView.bottomAnchor)
        ])
    }
    
    func setHeaderView(header: UIView) {
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)

        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        tabBarMenuViewTopAnchor.isActive = false
        tabBarMenuViewTopAnchor = tabBarMenuView.topAnchor.constraint(equalTo: header.bottomAnchor)
        tabBarMenuViewTopAnchor.isActive = true
    }
}

// MARK:- TabBarMenuDelegate
extension CustomTabBarViewController: CustomTabBarMenuDelegate {
    func tapMenu(to index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.tabBarPageView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK:- UIScrollViewDelegate
extension CustomTabBarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabBarMenuView.tabBarIndicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / CGFloat(numberOfPages)
    }
}

// MARK:- UICollectionViewDataSource
extension CustomTabBarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarPageCell.reusableIdentifier, for: indexPath) as? TabBarPageCell else { return UICollectionViewCell() }
        
        if let vc = tabBarViewControllers?[indexPath.item], let viewControllerView = vc.view {
            addChild(vc)
            cell.contentView.addSubview(viewControllerView)
            viewControllerView.frame = cell.contentView.bounds
            vc.didMove(toParent: self)
        }
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension CustomTabBarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tabBarPageView.frame.width, height: tabBarPageView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

