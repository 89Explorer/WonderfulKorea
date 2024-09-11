//
//  CustomCategoryCollectionView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class CustomCategoryCollectionView: UIView {
    
    // MARK: - UI Components
    let customCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(customCategoryCollectionView)
        configureConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        let customCategoryCollectionViewConstraints = [
            customCategoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customCategoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customCategoryCollectionView.topAnchor.constraint(equalTo: topAnchor),
            customCategoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(customCategoryCollectionViewConstraints)
    }
}
