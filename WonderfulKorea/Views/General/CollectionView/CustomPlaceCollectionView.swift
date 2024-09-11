//
//  CustomPlaceCollectionView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class CustomPlaceCollectionView: UIView {
    
    
    // MARK: - UI Components
    let customplaceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: 240, height: 200)
        
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
        
        addSubview(customplaceCollectionView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let customplaceCollectionViewConstraints = [
            customplaceCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customplaceCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customplaceCollectionView.topAnchor.constraint(equalTo: topAnchor),
            customplaceCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(customplaceCollectionViewConstraints)
    }
}
