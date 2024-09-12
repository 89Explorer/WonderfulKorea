//
//  HomeContentView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class HomeContentView: UIView {
    
    // MARK: - UI Components
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let homeTitleView: CustomTitleView = {
        let view = CustomTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryCollectionView: CustomCategoryCollectionView = {
        let view = CustomCategoryCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let placeCollectionView: CustomPlaceCollectionView = {
        let view = CustomPlaceCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let homeSubTitleView: CustomTitleView = {
        let view = CustomTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let placeTableView: CustomPlaceTableView = {
        let tableView = CustomPlaceTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(contentView)
        contentView.addSubview(homeTitleView)
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(placeCollectionView)
        contentView.addSubview(homeSubTitleView)
        contentView.addSubview(placeTableView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let contentViewConstraints = [
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let homeTitleViewConstraints = [
            homeTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            homeTitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ]
        
        let categoryCollectionViewConstraints = [
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoryCollectionView.topAnchor.constraint(equalTo: homeTitleView.bottomAnchor, constant: 24),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        let placeCollectionViewConstraints = [
            placeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            placeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            placeCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 16),
            placeCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let homeSubTitleViewConstraints = [
            homeSubTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeSubTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            homeSubTitleView.topAnchor.constraint(equalTo: placeCollectionView.bottomAnchor, constant: 32)
        ]
        
        let placeTableViewConstraints = [
            placeTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            placeTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            placeTableView.topAnchor.constraint(equalTo: homeSubTitleView.bottomAnchor, constant: 24),
            placeTableView.heightAnchor.constraint(equalToConstant: 1200),
            placeTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(homeTitleViewConstraints)
        NSLayoutConstraint.activate(categoryCollectionViewConstraints)
        NSLayoutConstraint.activate(placeCollectionViewConstraints)
        NSLayoutConstraint.activate(homeSubTitleViewConstraints)
        NSLayoutConstraint.activate(placeTableViewConstraints)
    }
}
