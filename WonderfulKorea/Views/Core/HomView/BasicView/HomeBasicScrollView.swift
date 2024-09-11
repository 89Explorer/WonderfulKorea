//
//  HomeBasicScrollView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class HomeBasicScrollView: UIView {
    
    // MARK: - UI Components
    private let homeBasicView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let homeContentView: HomeContentView = {
        let view = HomeContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(homeBasicView)
        homeBasicView.addSubview(homeContentView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let homeBasicViewConstraints = [
            homeBasicView.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeBasicView.trailingAnchor.constraint(equalTo: trailingAnchor),
            homeBasicView.topAnchor.constraint(equalTo: topAnchor),
            homeBasicView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let homeContentViewConstraints = [
            homeContentView.leadingAnchor.constraint(equalTo: homeBasicView.leadingAnchor),
            homeContentView.trailingAnchor.constraint(equalTo: homeBasicView.trailingAnchor),
            homeContentView.topAnchor.constraint(equalTo: homeBasicView.topAnchor),
            homeContentView.widthAnchor.constraint(equalTo: homeBasicView.widthAnchor),
            homeContentView.bottomAnchor.constraint(equalTo: homeBasicView.bottomAnchor, constant: -80)
        ]
        
        NSLayoutConstraint.activate(homeBasicViewConstraints)
        NSLayoutConstraint.activate(homeContentViewConstraints)
    }
    
    // MARK: - Functions
    func getHomeContentView() -> HomeContentView {
        return homeContentView
    }
    
    func getHomeTitleView(main: String, sub: String) {
        homeContentView.homeTitleView.configureTitle(main: main, sub: sub)
    }
    
    func getHomeSubTitleView(main: String, sub: String){
        homeContentView.homeSubTitleView.configureTitle(main: main, sub: sub)
    }
}
