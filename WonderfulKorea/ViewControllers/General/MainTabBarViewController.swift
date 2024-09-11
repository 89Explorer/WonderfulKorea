//
//  MainTabBarViewController.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: - UI Components
    private let mainTabBarView: CustomTabBarView = {
        let tabBarView = CustomTabBarView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        return tabBarView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "newgray")
        tabBar.isHidden = true

        view.addSubview(mainTabBarView)
        setViewControllers()
        configureConstraints()
        
        mainTabBarView.buttonTapped = { [weak self] index in
            self?.selectedIndex = index
        }
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        let mainTabBarViewConstraints = [
            mainTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            mainTabBarView.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(mainTabBarViewConstraints)
    }
    
    // MARK: - Fuctions
    private func setViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let locationVC = UINavigationController(rootViewController: LocationViewController())
        let planVC = UINavigationController(rootViewController: PlanViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())

        viewControllers = [homeVC, searchVC, locationVC, planVC, profileVC]
    }
}

