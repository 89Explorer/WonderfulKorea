//
//  DetailViewController.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/18/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    private var detailMainImage: [String] = []
    var model: Item?
    
    // MARK: - UI Components
    private let detailView: DetailBasicScrollView = {
        let view = DetailBasicScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "newgray")
        
        view.addSubview(detailView)
        configureConstraints()
        detailViewDelegate()
        
        //navigationController?.navigationBar.isHidden = true
        
        getDetailImage(contentId: model!.contentid)
        detailView.detailContentView.detailTitleLabel.configureTitle(main: (model?.title)!, sub: "")
        
    }

    
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let detailViewConstraints = [
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(detailViewConstraints)
    }
    
    // MARK: - Functions
    func detailViewDelegate() {
        detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView.delegate = self
        detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView.dataSource = self
        detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView.register(CustomImagePageCollectionViewCell.self, forCellWithReuseIdentifier: CustomImagePageCollectionViewCell.identifier)
    }
    
    func getDetailImage(contentId: String) {
        NetworkManager.shared.getSpotImage(contentId: contentId) { [weak self] result in
            switch result {
            case .success(let item):
                
                if item.isEmpty {
                    self?.setDefaultImage()
                } else {
                    self?.detailMainImage = item.compactMap { $0.originimgurl }
                }
                
                DispatchQueue.main.async {
                    self?.detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView.reloadData()
                    self?.detailView.detailContentView.pageControl.numberOfPages = (self?.detailMainImage.count)!
                    
                }
            case .failure(let error):
                self?.setDefaultImage()
                DispatchQueue.main.async {
                    self?.detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView.reloadData()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func setDefaultImage() {
        // 기본 이미지 URL 또는 로컬 이미지 파일의 이름을 detailMainImage에 배열 형태로 추가
        if let defaultImage = model?.firstimage {
            detailMainImage = [defaultImage]    // 기본 이미지의 URL 또는 로컬 이미지의 이름
        } else {
            detailMainImage = []
        }
    }
}


// MARK: - Extensions
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView {
            return detailMainImage.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == detailView.detailContentView.detailImageCollectionView.customImagePageCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomImagePageCollectionViewCell.identifier, for: indexPath) as? CustomImagePageCollectionViewCell else { return UICollectionViewCell() }
            
            let imageURL = detailMainImage[indexPath.item]
            
            cell.configureImage(with: imageURL)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        detailView.detailContentView.pageControl.currentPage = Int(pageIndex)
        
    }
}
