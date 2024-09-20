//
//  CustomImagePageCollectionView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/19/24.
//

import UIKit

class CustomImagePageCollectionView: UIView {
    
    // MARK: - Variables
    var detailImages: [String] = []
    
    // MARK: - UI Components
    let customImagePageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        // layout.itemSize = UIScreen.main.bounds.size
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        // layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(customImagePageCollectionView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let customImagePageCollectionViewConstraints = [
            customImagePageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customImagePageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customImagePageCollectionView.topAnchor.constraint(equalTo: topAnchor),
            customImagePageCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(customImagePageCollectionViewConstraints)
    }
}
