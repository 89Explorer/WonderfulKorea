//
//  HomeViewController.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/11/24.
//

import UIKit
import CoreLocation
import Contacts

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Variables
    private let placeCategories = ["자연", "인문(문화/예술/역사)", "추천코스", "음식/쇼핑"]
    private var placeSelectedIndex: Int = 0
    private var receivedItems: [Item] = []
    private var userLocation: String = ""
    
    // 위치 정보
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    
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
        //        getHomSubTitleView(main: "동동이님, 근처에는 말이에요 😄", sub: "현재 위치: \(userLocation)")
        
        configureNavigationBar()
        configureConstraints()
        
        collectionViewDelegate()
        tableViewDeleagte()
        
        getRandomPageData(contentTypeId: "12")
        checkUserDeviceLocationServiceAuthorization()
        print(userLocation)
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
    
    
    // 위치 정보 관련 함수
    func checkUserDeviceLocationServiceAuthorization() {
        
        // 3.1 디바이스 자체에 위치 서비스가 활성화 상태인지 확인한다.
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                // 시스템 설정으로 유도하는 커스텀 얼럿
                self.showRequestLocationServiceAlert()
                return
            }
        }
        
        // 위치 서비스가 활성화 상태라면 권한 오청
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // iOS 14 이상에서는 권한 상태를 델리게이트 메서드에서 처리
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 3.2 사용자 디바이스의 위치 서비스가 활성화 상태라면,  앱에 대한 권한 상태를 확인해야 한다.
        let authorizationStatus: CLAuthorizationStatus
        
        // 앱의 권한 상태 가져오는 코드 (iOS 버전에 따라 분기처리)
        if #available(iOS 14.0, *) {
            authorizationStatus = manager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    // 4. 앱에 대한 위치 권한이 부여된 상태인지 확인하는 메서드 추가
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            print("Not determained")
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            // 권한 요청을 보낸다.
            
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            print("Restricted or denied")
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            print("Authorized")
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default) { [weak self] _ in
            self?.reloadData()  // 여기에 await는 필요하지 않습니다.
        }
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true)
    }
    
    // 2. 위치 업데이트 메서드 (위도, 경도를 통해 주소 변환)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // 경도와 위도를 통해 지번/도로명 주소 변환
        reverseGeocode(location: location) { userLocation in
            if let userLocation = userLocation {
                print("User location: \(userLocation)")
                // 여기서 userLocation을 사용하여 추가 작업 수행 가능
                // 메인 스레드에서 UI 업데이트
                DispatchQueue.main.async {
                    self.getHomSubTitleView(main: "동동이님, 근처에는 말이에요 😄", sub: "현재 위치: \(userLocation)")
                }
                
            } else {
                print("Failed to retrieve user location")
            }
        }
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        guard let location = locations.last else { return }
    //
    //        // 경도와 위도를 통해 지번/도로명 주소 변환
    //        reverseGeocode(location: location)
    //    }
    
    // 3. Reverse Geocoding을 사용하여 위도와 경도를 주소로 변환하는 메서드
    // 외부에서 호출할 때 userLocation이 설정된 후 실행할 동작을 정의할 수 있도록 completion handler를 추가합니다.
    func reverseGeocode(location: CLLocation, completion: @escaping (String?) -> Void) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil) // 에러가 발생한 경우 nil을 반환
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil) // placemark가 없는 경우 nil을 반환
                return
            }
            
            // 지번 주소 구성
            let country = placemark.country ?? ""
            let administrativeArea = placemark.administrativeArea ?? ""
            let locality = placemark.locality ?? ""
            let subLocality = placemark.subLocality ?? ""
            // thoroughfare와 subThoroughfare는 생략
            
            let jibunAddress = "\(administrativeArea) \(locality) \(subLocality)"
            
            // userLocation에 값을 할당
            self.userLocation = jibunAddress
            
            // 완료된 후 jibunAddress를 completion handler로 전달
            completion(jibunAddress)
        }
    }
    
    //    func reverseGeocode(location: CLLocation) {
    //        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
    //            if let error = error {
    //                print("Reverse geocoding failed: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let placemark = placemarks?.first else {
    //                print("No placemark found")
    //                return
    //            }
    //
    //            // 지번 주소 구성
    //            let country = placemark.country ?? ""
    //            let administrativeArea = placemark.administrativeArea ?? ""
    //            let locality = placemark.locality ?? ""
    //            let subLocality = placemark.subLocality ?? ""
    //            let thoroughfare = placemark.thoroughfare ?? ""
    //            let subThoroughfare = placemark.subThoroughfare ?? ""
    //
    //            // 지번 주소 출력 (예: 대한민국 서울특별시 강남구 역삼동 123번지)
    //            // let jibunAddress = "\(country) \(administrativeArea) \(locality) \(subLocality) \(thoroughfare) \(subThoroughfare)"
    //
    //            let jibunAddress = "\(country) \(administrativeArea) \(locality) \(subLocality)"
    //
    //            self.userLocation = jibunAddress
    //        }
    //    }
    
    //    func reverseGeocode(location: CLLocation) {
    //        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
    //            if let error = error {
    //                print("Reverse geocoding failed: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let placemark = placemarks?.first else {
    //                print("No placemark found")
    //                return
    //            }
    //
    //            // 지번 주소 (subThoroughfare: 번지, thoroughfare: 도로명)
    //            if let thoroughfare = placemark.thoroughfare, let subThoroughfare = placemark.subThoroughfare {
    //                print("도로명 주소: \(thoroughfare) \(subThoroughfare)")
    //            }
    //
    //            // 행정구역 (locality: 시, administrativeArea: 도)
    //            if let locality = placemark.locality, let administrativeArea = placemark.administrativeArea {
    //                print("행정구역: \(locality), \(administrativeArea)")
    //            }
    //
    //            // 전체 주소 출력
    //            if let postalAddress = placemark.postalAddress {
    //                let address = CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress)
    //                print("전체 주소: \(address)")
    //            }
    //        }
    //    }
    
    
    
    private func reloadData() {
        // 컬렉션뷰 및 테이블뷰의 데이터를 다시 로드
        homeView.getHomeContentView().categoryCollectionView.customCategoryCollectionView.reloadData()
        homeView.getHomeContentView().placeCollectionView.customplaceCollectionView.reloadData()
        homeView.getHomeContentView().placeTableView.customPlaceTableView.reloadData()
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
//
//
//extension HomeViewController: CLLocationManagerDelegate {
//    // 사용자의 위치를 성공적으로 가져왔을 때 호출
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확하다고 한다.
//        if let coordinate = locations.last?.coordinate {
//            // ⭐️ 사용자 위치 정보 사용
//            print("사용자의 위치 - 위도: \(coordinate.latitude), 경도: \(coordinate.longitude)")
//        }
//
//        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
//        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
//        locationManager.stopUpdatingLocation()
//    }
//
//    // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(#function)
//        print("위치 정보를 가져오는 데 실패했습니다: \(error.localizedDescription)")
//    }
//
//    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 이상)
//    private func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
//        checkUserDeviceLocationServiceAuthorization()
//    }
//
//    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 미만)
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
//        checkUserDeviceLocationServiceAuthorization()
//    }
//}
