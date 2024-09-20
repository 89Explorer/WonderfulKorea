//
//  DetailContentView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/19/24.
//

import UIKit

class DetailContentView: UIView {
    
    // MARK: - UI Components
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        return view
    }()
    
    let detailImageCollectionView: CustomImagePageCollectionView = {
        let imageView = CustomImagePageCollectionView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let detailTitleLabel: CustomTitleView = {
        let view = CustomTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(contentView)
        contentView.addSubview(detailImageCollectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(detailTitleLabel)
        
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
        
        let detailImageCollectionViewConstraints = [
            detailImageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailImageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailImageCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailImageCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ]

        let pageControlConstraints = [
            pageControl.topAnchor.constraint(equalTo: detailImageCollectionView.bottomAnchor, constant: -40),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let detailTitleLabelConstraints = [
            detailTitleLabel.topAnchor.constraint(equalTo: detailImageCollectionView.bottomAnchor, constant: 25),
            detailTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            detailTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(detailImageCollectionViewConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
        NSLayoutConstraint.activate(detailTitleLabelConstraints)
    }
}
