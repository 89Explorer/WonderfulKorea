//
//  CustomPlaceTableViewCell.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/12/24.
//

import UIKit
import SDWebImage

class CustomPlaceTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "CustomPlaceTableViewCell"
    
    // MARK: - UI Components
    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let nearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "attractions")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nearStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let titleRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()
    
    let nearTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = .black
        label.text = "전주 한옥 마을"
        return label
    }()
    
    let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    
    let addressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "location.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .orange
        return imageView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "경기도 고양시 덕양구"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    
    let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .orange
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4.7"
        label.textColor = .black
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = .black
        return label
    }()
    
    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        // stackView.distribution = .fill
        return stackView
    }()
    
    //    let secondCategoryLabel: UILabel = {
    //        let label = UILabel()
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.text = "숙박"
    //        label.backgroundColor = .orange
    //        label.layer.cornerRadius = 5
    //        label.clipsToBounds = true
    //        label.textColor = .black
    //        label.font = UIFont(name: "DungGeunMo", size: 16)
    //        label.textColor = .black
    //        return label
    //    }()
    //
    //    let thirdCategoryLabel: UILabel = {
    //        let label = UILabel()
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.text = "호텔"
    //        label.backgroundColor = .orange
    //        label.layer.cornerRadius = 5
    //        label.clipsToBounds = true
    //        label.textColor = .black
    //        label.font = UIFont(name: "DungGeunMo", size: 16)
    //        label.textColor = .black
    //        return label
    //    }()
    
    let secondCategoryLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "숙박"
        label.backgroundColor = .newgray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    let thirdCategoryLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "호텔"
        label.backgroundColor = .newgray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubview(basicView)
        
        basicView.addSubview(nearImageView)
        basicView.addSubview(nearStackView)
        basicView.addSubview(categoryStackView)
        
        // nearStackView.addArrangedSubview(nearTitleLabel)
        nearStackView.addArrangedSubview(titleRatingStackView)
        nearStackView.addArrangedSubview(addressStackView)
        // nearStackView.addArrangedSubview(ratingStackView)
        //nearStackView.addArrangedSubview(categoryStackView)
        
        titleRatingStackView.addArrangedSubview(nearTitleLabel)
        titleRatingStackView.addArrangedSubview(ratingStackView)
        addressStackView.addArrangedSubview(addressImageView)
        addressStackView.addArrangedSubview(addressLabel)
        
        ratingStackView.addArrangedSubview(ratingImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        categoryStackView.addArrangedSubview(secondCategoryLabel)
        categoryStackView.addArrangedSubview(thirdCategoryLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            basicView.topAnchor.constraint(equalTo: contentView.topAnchor),
            basicView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let nearImageViewConstraints = [
            nearImageView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 8),
            nearImageView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 8),
            nearImageView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -8),
            nearImageView.widthAnchor.constraint(equalToConstant: 104)
        ]
        
        let nearStackViewConstraints = [
            nearStackView.leadingAnchor.constraint(equalTo: nearImageView.trailingAnchor, constant: 8),
            nearStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -16),
            nearStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ]
        
        let addressImageViewConstraints = [
            addressImageView.widthAnchor.constraint(equalToConstant: 16),
            addressImageView.heightAnchor.constraint(equalToConstant: 16)
        ]
        
        let ratingImageViewConstraints = [
            ratingImageView.widthAnchor.constraint(equalToConstant: 16),
            ratingImageView.heightAnchor.constraint(equalToConstant: 16)
        ]
        
        let categoryStackViewConstraints = [
            categoryStackView.leadingAnchor.constraint(equalTo: nearImageView.trailingAnchor, constant: 16),
            categoryStackView.topAnchor.constraint(equalTo: nearStackView.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(nearImageViewConstraints)
        NSLayoutConstraint.activate(nearStackViewConstraints)
        NSLayoutConstraint.activate(addressImageViewConstraints)
        NSLayoutConstraint.activate(ratingImageViewConstraints)
        NSLayoutConstraint.activate(categoryStackViewConstraints)
    }
    
    // MARK: - Functions
    func configureData(with model: Item) {
        
        guard let posterPath = model.firstimage,
              var title = model.title,
              var address = model.addr1 else { return }
        
        title = (title.count != 0) ? title : " - "
        address = (address.count != 0) ? address : " - "
        
        let moodifiedAddress = getAddressPrefix(fullAddress: address, wordCount: 3)
        
        let securePosterURL = posterPath.replacingOccurrences(of: "http://", with: "https://")
        
        if let url = URL(string: securePosterURL) {
            nearImageView.sd_setImage(with: url)
        } else {
            nearImageView.image = UIImage(systemName: "house.fill")
        }
        
        let modifiedTitle = title.removingParentheses()
        nearTitleLabel.text = modifiedTitle
        addressLabel.text = moodifiedAddress
    }
    
    // 띄어쓰기로 문자열 구분
    func getAddressPrefix(fullAddress: String, wordCount: Int) -> String {
        let components = fullAddress.split(separator: " ")  // 띄어쓰기 기준으로 문자열 분리
        let prefix = components.prefix(wordCount)          // 원하는 단어 개수만큼 가져옴
        return prefix.joined(separator: " ")               // 다시 띄어쓰기로 합침
    }
}


// MARK: - Class
class PaddingLabel: UILabel {
    var topInset: CGFloat = 5
    var bottomInset: CGFloat = 5
    var leftInset: CGFloat = 10
    var rightInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}


