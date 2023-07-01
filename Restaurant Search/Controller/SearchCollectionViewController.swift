//
//  SearchCollectionViewController.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/27.
//

import UIKit
import CoreLocation
import SwiftUI

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    private var searchController = UISearchController()
    private var gourmetSearch = HPGourmetSearch()
    var dataSource: UICollectionViewDiffableDataSource<Section, HPShop>!
    var locationManager = LocationManager.shared
    var lastUpdatedLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.sizeToFit()
        
        self.navigationItem.searchController = searchController
        initializeView()
    }
    
    func initializeView() {
        configureCollectionView()
        configureDataSource()
        setupLocationManager()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateLocation), name: Notification.Name("didUpdateLocation"), object: locationManager.currentLocation)
    }
    
    func setupLocationManager() {
        locationManager.startUpdatingLocation()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize,
                                                         repeatingSubitem: item,
                                                         count: 1)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }, configuration: configuration)
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HPShop>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration {
                SearchCell(title: item.name, detail: item.address)
            }
            
            return cell
        }
    }
    
    func searchGourmet(at coordinate: CLLocation) {
        gourmetSearch.search(at: coordinate.coordinate) { shops, error in
            var snapshot = NSDiffableDataSourceSnapshot<Section, HPShop>()
            snapshot.appendSections([.main])
            
            let items = shops
            snapshot.appendItems(items, toSection: .main)
            
            DispatchQueue.main.async {
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
        }
    }
    
    @objc func didUpdateLocation(_ notification: Notification) {
        if let location = notification.object as? CLLocation {
            searchGourmet(at: location)
            lastUpdatedLocation = location
        }
    }
    
}
