//
//  HomeViewController.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class HomeViewController: UIViewController{
    
    // MARK: - Variables
    private let placeCategories = ["자연", "인문(문화/예술/역사)", "추천코스", "음식/쇼핑"]
    private var placeSelectedIndex: Int = 0
    private var receivedItems: [Item] = []
    
    
    
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
        
        getRandomPageData(contentTypeId: "12")
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
    // 랜덤으로 카테고리별 데이터를 받아오는 함수
    private func getRandomPageData(contentTypeId: String) {
        NetworkManager.shared.fetchRandomPageData(contentTypeId: contentTypeId) { [weak self] results in
            switch results {
            case .success(let items):
                // firstImage가 nil이 아니고, 빈 문자열이 아닌 모든 요소 확인
                let validItems = items.filter {
                    if let firstImage = $0.firstimage {
                        return !firstImage.isEmpty
                    }
                    return false
                }
                DispatchQueue.main.async {
                    self?.receivedItems = validItems
                    self?.homeView.getHomeContentView().placeCollectionView.customplaceCollectionView.reloadData()
                    // 데이터를 다시 로드한 후 첫 번째 행으로 스크롤
                    //                    if !validItems.isEmpty {
                    //
                    //                        self?.mainTableView.getMainTable().scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    //                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
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
    
    func isCategoryCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView
    }
    
    func isPlaceCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == homeView.getHomeContentView().placeCollectionView.customplaceCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isCategoryCollectionView(collectionView) {
            return placeCategories.count
        } else if isPlaceCollectionView(collectionView) {
            return receivedItems.count
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isCategoryCollectionView(collectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCategoryCollectionViewCell.identifier, for: indexPath) as? CustomCategoryCollectionViewCell else { return UICollectionViewCell() }
            
            let isSelected = indexPath.item == placeSelectedIndex
            let title = placeCategories[indexPath.item]
            
            cell.configureCategory(title: title, isSelected: isSelected)
            
            return cell
            
        } else if isPlaceCollectionView(collectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomPlaceCollectionViewCell.identifier, for: indexPath) as? CustomPlaceCollectionViewCell else { return UICollectionViewCell() }
            
            let model = receivedItems[indexPath.row]
            cell.getRandomPlaceData(with: model)
            cell.backgroundColor = .clear
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView {
            let previousSelectedIndex = placeSelectedIndex  // 이전에 선택된 인덱스 저장
            placeSelectedIndex = indexPath.item  // 새로운 선택 인덱스로 업데이트
            
            let selectedIndexPath = IndexPath(item: placeSelectedIndex, section: 0)
            let previousSelectedIndexPath = IndexPath(item: previousSelectedIndex, section: 0)
            
            // 이전 선택 항목이 유효한 경우에만 리로드
            if previousSelectedIndex != placeSelectedIndex {
                homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView.reloadItems(at: [selectedIndexPath, previousSelectedIndexPath])
            }
            
            // 필요한 데이터 처리
            var selectedCategory: ContentCategory?
            switch placeSelectedIndex {
            case 0:
                selectedCategory = .attractions
            case 1:
                selectedCategory = .facilities
            case 2:
                selectedCategory = .course
            case 3:
                selectedCategory = .restaurant
            default:
                break
            }
            
            if let category = selectedCategory {
                getRandomPageData(contentTypeId: category.contentTypeId)
            }
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
