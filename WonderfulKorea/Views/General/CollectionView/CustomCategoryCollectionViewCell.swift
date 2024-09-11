//
//  CustomCategoryCollectionViewCell.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class CustomCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "CustomCategoryCollectionViewCell"
    
    // MARK: - UI COMPONETS
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DungGeunMo", size: 18)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let underLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.isHidden = true
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(underLine)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let underLineConstraints = [
            underLine.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 4),
            underLine.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -4),
            underLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            underLine.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(underLineConstraints)
    }
    
    // MARK: - Functions
    func configureCategory(title: String, isSelected: Bool) {
        titleLabel.text = title
        underLine.isHidden = !isSelected
        if isSelected == true {
            titleLabel.textColor = .systemRed
        } else {
            titleLabel.textColor = .black
        }
    }
}
