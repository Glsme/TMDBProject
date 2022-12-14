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
import TMDBUIFramework

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
        annotation.title = "νμ¬ μμΉ"
        
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
    
    private func showChosingTheaterActionSheet() {
        let theaterAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let lotteCinema = UIAlertAction(title: "λ‘―λ°μλ€λ§", style: .default) { value in
            for item in TheaterList.mapAnnotations {
                if item.type == value.title {
                    self.setRegionAndAnnotation(latitude: item.latitude, longitude: item.longitude, theaterName: item.location)
                }
            }
        }
        
        let megaBox = UIAlertAction(title: "λ©κ°λ°μ€", style: .default) { value in
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
        
        let all = UIAlertAction(title: "μ μ²΄ λ³΄κΈ°", style: .default) { value in
            for item in TheaterList.mapAnnotations {
                self.setRegionAndAnnotation(latitude: item.latitude, longitude: item.longitude, theaterName: item.location)
            }
        }
        
        let cancel = UIAlertAction(title: "μ·¨μ", style: .cancel, handler: nil)
        
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
            print("μ΄ λλ°μ΄μ€λ iOS 14.0 μ΄μμλλ€.")
            authorizationStatus = locationManager.authorizationStatus
        } else {
            print("μ΄ λλ°μ΄μ€λ iOS 14.0 λ―Έλ§μλλ€.")
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("μμΉ μλΉμ€κ° κΊΌμ Έ μμ΄μ μμΉ κΆν μμ²­μ νμ§ λͺ»ν©λλ€.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("DENIED, μμ΄ν° μ€μ μΌλ‘ μ λν©λλ€.")
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
