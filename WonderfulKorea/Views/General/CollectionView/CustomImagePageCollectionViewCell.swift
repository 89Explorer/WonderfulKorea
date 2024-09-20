//
//  CustomImagePageCollectionViewCell.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/19/24.
//

import UIKit
import SDWebImage

class CustomImagePageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "CustomImagePageCollectionViewCell"
    
    // MARK: - UI Components
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func configureConstraints() {
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    // MARK: - Functions
    func configureImage(with imageURL: String) {
        
        let securePosterURL = imageURL.replacingOccurrences(of: "http://", with: "https://")
        
        if let url = URL(string: securePosterURL) {
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "house.fill")
        }
    }
}
