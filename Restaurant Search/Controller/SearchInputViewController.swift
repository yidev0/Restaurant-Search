//
//  SearchInputViewController.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/07/03.
//

import UIKit
import CoreLocation

class SearchInputViewController: UIViewController {

    @IBOutlet var rangeLabel: UILabel!
    @IBOutlet var rangeControl: UISegmentedControl!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var coordinateLabels: [UILabel]!
    @IBOutlet var coordinateValueLabels: [UILabel]!
    
    var locationManager = LocationManager.shared
    var selectedRange: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupButton()
        setupLabel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateLocation), name: Notification.Name("didUpdateLocation"), object: locationManager.currentLocation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
    }
    
    func setupSegmentedControl() {
        rangeControl.removeAllSegments()
        for i in 0..<5 {
            rangeControl.insertSegment(
                withTitle: ["300m", "500m", "1000m", "2000m", "3000m"][i],
                at: i,
                animated: true
            )
        }
        rangeControl.selectedSegmentIndex = selectedRange
    }
    
    func setupButton() {
        searchButton.setTitle("Search", for: .normal)
    }
    
    func setupLabel() {
        for i in 0..<2 {
            coordinateLabels[i].text = ["Latitude", "Longitude"][i]
            if let coordinate = locationManager.currentLocation?.coordinate {
                coordinateValueLabels[i].text = "\([coordinate.latitude, coordinate.longitude][i])"
            }
        }
        rangeLabel.text = "Range"
    }
    
    @objc func didUpdateLocation(_ notification: Notification) {
        if let location = notification.object as? CLLocation {
            for i in 0..<2 {
                coordinateValueLabels[i].text = "\([location.coordinate.latitude, location.coordinate.longitude][i])"
            }
        }
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        guard let coordinate = locationManager.currentLocation?.coordinate else { return }
        var urlString: String {
            // TODO: API Key
            let apiKey = "fa66f5797885a747"
            let base = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)"
            return base + "&lat=\(coordinate.latitude)&lng=\(coordinate.longitude)" + "&range=\(selectedRange)" + "&count=10" + "&format=json"
        }
        
        if let url = URL(string: urlString) {
            performSegue(withIdentifier: "toResult", sender: url)
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            if let destination = segue.destination as? SearchCollectionViewController,
               let currentLocation = locationManager.currentLocation {
                destination.searchRange = selectedRange
                destination.lastUpdatedLocation = currentLocation
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
}
