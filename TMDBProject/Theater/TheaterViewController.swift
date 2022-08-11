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
    var locationStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        checkUserDeviceLocationServiceAuthorization()
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        theaterMapView?.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "현재 위치"
        
        theaterMapView.addAnnotation(annotation)
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
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationStatus = true
        default:
            print("DEFUALT")
        }
    }
    
    func showRequestLocationServiceAlert() {
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
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
