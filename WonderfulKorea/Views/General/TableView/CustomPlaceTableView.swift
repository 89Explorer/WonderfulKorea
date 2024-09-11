//
//  CustomPlaceTableView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/12/24.
//

import UIKit

class CustomPlaceTableView: UIView {
    
    // MARK: - UI Components
    let customPlaceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(customPlaceTableView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let customPlaceTableViewConstraints = [
            customPlaceTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customPlaceTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customPlaceTableView.topAnchor.constraint(equalTo: topAnchor),
            customPlaceTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(customPlaceTableViewConstraints)
    }
}
