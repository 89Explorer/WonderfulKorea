//
//  DetailBasicScrollView.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/18/24.
//

import UIKit

class DetailBasicScrollView: UIView {
    
    // MARK: - UI Components
    private let detailBasicView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailContentView: DetailContentView = {
        let view = DetailContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(detailBasicView)
        detailBasicView.addSubview(detailContentView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let detailBasicViewConstraints = [
            detailBasicView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailBasicView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailBasicView.topAnchor.constraint(equalTo: topAnchor),
            detailBasicView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let detailContentViewConstraints = [
            detailContentView.leadingAnchor.constraint(equalTo: detailBasicView.leadingAnchor),
            detailContentView.trailingAnchor.constraint(equalTo: detailBasicView.trailingAnchor),
            detailContentView.topAnchor.constraint(equalTo: detailBasicView.topAnchor),
            detailContentView.widthAnchor.constraint(equalTo: detailBasicView.widthAnchor), // 가로 크기를 UIScrollView와 같게,
            detailContentView.bottomAnchor.constraint(equalTo: detailBasicView.bottomAnchor, constant: -80)
        ]
        
        NSLayoutConstraint.activate(detailBasicViewConstraints)
        NSLayoutConstraint.activate(detailContentViewConstraints)
    }
}
