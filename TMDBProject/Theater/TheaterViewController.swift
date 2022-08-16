//
//  TheaterViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

class TheaterViewController: UIViewController {
    
    @IBOutlet weak var theaterMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    private var locationStatus = false
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(theaterListButtonClicked))
        
        checkUserDeviceLocationServiceAuthorization()
    }
    
    @objc func theaterListButtonClicked() {
        theaterMapView.removeAnnotations(theaterMapView.annotations)
        //        theaterMapView.showsUserLocation = true
        showChosingTheaterActionSheet()
    }
    
    func setUserRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        theaterMapView?.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "현재 위치"
        
        theaterMapView.addAnnotation(annotation)
    }
    
    func setRegionAndAnnotation(latitude: Double, longitude: Double, theaterName: String) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        theaterMapView?.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = theaterName
        
        theaterMapView.addAnnotation(annotation)
    }
    
    func showChosingTheaterActionSheet() {
        let theaterAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { value in
            for item in TheaterList.mapAnnotations {
                if item.type == value.title {
                    self.setRegionAndAnnotation(latitude: item.latitude, longitude: item.longitude, theaterName: item.location)
                }
            }
        }
        
        let megaBox = UIAlertAction(title: "메가박스", style: .default) { value in
            for item in TheaterList.mapAnnotations {
                if item.type == value.title {
                    self.setRegionAndAnnotation(latitude: item.latitude, longitude: item.longitude, theaterName: item.location)
                }
            }
        }
        
        let cgv = UIAlertAction(title: "CGV", style: .default) { value in
            for item in TheaterList.mapAnnotations {
                if item.type == value.title {
                    self.setRegionAndAnnotation(latitude: item.latitude, longitude: item.longitude, theaterName: item.location)
                }
            }
        }
        
        let all = UIAlertAction(title: "전체 보기", style: .default) { value in
            for item in TheaterList.mapAnnotations {
                self.setRegionAndAnnotation(latitude: item.latitude, longitude: item.longitude, theaterName: item.location)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        theaterAlert.addAction(lotteCinema)
        theaterAlert.addAction(megaBox)
        theaterAlert.addAction(cgv)
        theaterAlert.addAction(all)
        theaterAlert.addAction(cancel)
        
        present(theaterAlert, animated: true)
    }
}

extension TheaterViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            print("이 디바이스는 iOS 14.0 이상입니다.")
            authorizationStatus = locationManager.authorizationStatus
        } else {
            print("이 디바이스는 iOS 14.0 미만입니다.")
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 하지 못합니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도합니다.")
            showRequestLocationServiceAlert()
            setUserRegionAndAnnotation(center: defaultCoordinate)
            showChosingTheaterActionSheet()
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationStatus = true
            showChosingTheaterActionSheet()
        default:
            print("DEFUALT")
            showChosingTheaterActionSheet()
        }
    }
    
    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension TheaterViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setUserRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
