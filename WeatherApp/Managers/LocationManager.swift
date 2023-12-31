//
//  LocationManager.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import CoreLocation
import UIKit
import Combine

class LocationManager: NSObject {
    
    //MARK: Properites
    
    static let shared: LocationManager = LocationManager()
 private(set) static var authorizationStatus: CLAuthorizationStatus?
//    private(set) static var authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Never>()
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    private let geoCoder = CLGeocoder()
    private var currentPlaceMark: CLPlacemark? {
        didSet {
            placeMark = currentPlaceMark
            cityName = currentPlaceMark?.locality ?? ""
        }
    }
    
    @Published public var placeMark: CLPlacemark!
    @Published public var cityName: String = ""
    
    //MARK: - Init
    
    private override init() {
        super.init()
        
        startLocationUpdate()
    }
    
    func startLocationUpdate() {
        
        if locationManager.authorizationStatus == .notDetermined || locationManager.authorizationStatus == .denied {
            locationManagerSetUp()
        } else {
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.pausesLocationUpdatesAutomatically = true
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            let appState = UIApplication.shared.applicationState
            if appState == .active {
                self.locationManager.startUpdatingHeading()
                self.locationManager.startUpdatingLocation()
            } else {
                self.locationManager.startMonitoringSignificantLocationChanges()
                self.locationManager.startMonitoringVisits()
                
            }
        }
        
    }
    
    private func locationManagerSetUp() {
        LocationManager.authorizationStatus = locationManager.authorizationStatus
        switch locationManager.authorizationStatus {
            
        case .restricted, .denied:
           break
            
        case .authorizedWhenInUse:
            startLocationUpdate()
            
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways:
            startLocationUpdate()
            
        default:
            break
        }
    }
}

//MARK: - LocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        self.currentLocation = location
        
        geoCoder.reverseGeocodeLocation(currentLocation) { [weak self] (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else { return }
            self?.currentPlaceMark = currentLocPlacemark
            self?.locationManager.stopUpdatingHeading()
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        LocationManager.authorizationStatus = manager.authorizationStatus
    }
    
}
