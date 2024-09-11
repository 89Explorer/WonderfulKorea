//
//  CustomPlaceCollectionViewCell.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/12/24.
//

import UIKit

class CustomPlaceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "CustomPlaceCollectionViewCell"
    
    // MARK: - UI COMPONENTS
    private let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let spotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "attractions")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private let spotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let spotTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DungGeunMo", size: 14)
        label.text = "전주 한옥 마을"
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let spaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let ratingStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DungGeunMo", size: 14)
        label.text = "4.5"
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let addressImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "location.circle.fill")
        imageView.tintColor = .orange
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DungGeunMo", size: 12)
        label.text = "경기도 고양시 덕양구"
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        contentView.addSubview(basicView)
        basicView.addSubview(spotImageView)
        basicView.addSubview(titleAddressStackView)
        
        titleAddressStackView.addArrangedSubview(spotStackView)
        spotStackView.addArrangedSubview(spotTitleLabel)
        // spotStackView.addArrangedSubview(spaceView)
        spotStackView.addArrangedSubview(ratingStackView)
        
        ratingStackView.addArrangedSubview(ratingStarImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        titleAddressStackView.addArrangedSubview(addressStackView)
        addressStackView.addArrangedSubview(addressImageview)
        addressStackView.addArrangedSubview(addressLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            basicView.topAnchor.constraint(equalTo: contentView.topAnchor),
            basicView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let spotImageViewConstraints = [
            spotImageView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 10),
            spotImageView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -10),
            spotImageView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 10),
            spotImageView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -60)
        ]
        
        let titleAddressStackViewConstraints = [
            titleAddressStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 16),
            titleAddressStackView.topAnchor.constraint(equalTo: spotImageView.bottomAnchor, constant: 8),
            titleAddressStackView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -16),
        ]
        
        // ratingStarImageView 크기 제약 조건 추가
        let ratingStarImageViewConstraints = [
            ratingStarImageView.widthAnchor.constraint(equalToConstant: 16),
            ratingStarImageView.heightAnchor.constraint(equalToConstant: 16)
        ]
        
        let addressImageviewConstraints = [
            addressImageview.widthAnchor.constraint(equalToConstant: 16),
            addressImageview.heightAnchor.constraint(equalToConstant: 16)
        ]

        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(spotImageViewConstraints)
        NSLayoutConstraint.activate(titleAddressStackViewConstraints)
        NSLayoutConstraint.activate(ratingStarImageViewConstraints)
        NSLayoutConstraint.activate(addressImageviewConstraints)
    }
    
    // MARK: - Functions
    // 외부 api를 통해 데이터 받아오는 거 함수 
}
