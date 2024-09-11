//
//  HomeViewController.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class HomeViewController: UIViewController{
    
    // MARK: - Variables
    private let placeCategories = ["자연", "인문(문화/예술/역사)", "추천코스", "음식"]
    private var placeSelectedIndex: Int = 0
    
    
    
    
    // MARK: - UI Components
    private let homeView: HomeBasicScrollView = {
        let view = HomeBasicScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeView)
        
        title = "Home"
        getHomeTitleView(main: "동동이님, 이런 곳은 어떤가요? 😀", sub: "카테고리 별 랜덤 리스트")
        getHomSubTitleView(main: "동동이님, 근처에는 말이에요 😄", sub: "현재 위치: 경기도 고양시 덕양구")
        
        configureNavigationBar()
        configureConstraints()
        
        collectionViewDelegate()
        tableViewDeleagte()
    }

    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let homeViewConstraints = [
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(homeViewConstraints)
    }
    
    
    // MARK: - Functions
    // 네비게이션바 설정
    private func configureNavigationBar() {
        let originalImage = UIImage(named: "trip-logo-removebg")
        let scaledSize = CGSize(width: 45, height: 45) // 시스템 버튼과 비슷한 크기
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        originalImage?.draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 원본 이미지 색상을 유지하기 위해 렌더링 모드를 .alwaysOriginal로 설정
        let originalColorImage = scaledImage?.withRenderingMode(.alwaysOriginal)
        
        let barButton = UIBarButtonItem(image: originalColorImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButton
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .black
        
        // `UINavigationBarAppearance` 객체 생성
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "newgray")
        
        // 폰트 로드 실패 시 기본 시스템 폰트로 대체
        let customFont = UIFont(name: "DungGeunMo", size: 24) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: customFont
        ]
        
        // 라지 타이틀 관련 설정을 생략하고, 일반 타이틀만 설정
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 라지 타이틀 비활성화
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // homeTitleView의 메인, 서브 제목 가져오는 함수
    private func getHomeTitleView(main: String, sub: String) {
        homeView.getHomeContentView().homeTitleView.configureTitle(main: main, sub: sub)
    }
    
    private func getHomSubTitleView(main: String, sub: String) {
        homeView.getHomeContentView().homeSubTitleView.configureTitle(main: main, sub: sub)
    }
    
    private func collectionViewDelegate() {
        homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView.delegate = self
        homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView.dataSource = self
        homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView.register(CustomCategoryCollectionViewCell.self, forCellWithReuseIdentifier: CustomCategoryCollectionViewCell.identifier)
        
        homeView.getHomeContentView().placeCollectionView.customplaceCollectionView.delegate = self
        homeView.getHomeContentView().placeCollectionView.customplaceCollectionView.dataSource = self
        homeView.getHomeContentView().placeCollectionView.customplaceCollectionView.register(CustomPlaceCollectionViewCell.self, forCellWithReuseIdentifier: CustomPlaceCollectionViewCell.identifier)
    }
    
    private func tableViewDeleagte() {
        homeView.getHomeContentView().placeTableView.customPlaceTableView.delegate = self
        homeView.getHomeContentView().placeTableView.customPlaceTableView.dataSource = self
        homeView.getHomeContentView().placeTableView.customPlaceTableView.register(CustomPlaceTableViewCell.self, forCellReuseIdentifier: CustomPlaceTableViewCell.identifier)
    }
}



// MARK: - Extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView {
            return placeCategories.count
        } else if collectionView == homeView.getHomeContentView().placeCollectionView.customplaceCollectionView {
            return 10
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCategoryCollectionViewCell.identifier, for: indexPath) as? CustomCategoryCollectionViewCell else { return UICollectionViewCell() }
            
            let isSelected = indexPath.item == placeSelectedIndex
            let title = placeCategories[indexPath.item]
            
            cell.configureCategory(title: title, isSelected: isSelected)
            
            return cell
            
        } else if collectionView == homeView.getHomeContentView().placeCollectionView.customplaceCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomPlaceCollectionViewCell.identifier, for: indexPath) as? CustomPlaceCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .clear
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView {
            placeSelectedIndex = indexPath.item
            print("\(placeCategories[placeSelectedIndex]) - called")
            homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomPlaceTableViewCell.identifier, for: indexPath) as? CustomPlaceTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
