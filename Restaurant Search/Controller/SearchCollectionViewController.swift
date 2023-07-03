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
    var lastUpdatedLocation: CLLocation!
    var searchRange: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search".localize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.sizeToFit()
        
        self.navigationItem.searchController = searchController
        initializeView()
    }
    
    func initializeView() {
        configureCollectionView()
        configureDataSource()
        
        searchGourmet(at: lastUpdatedLocation)
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
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(0.5)
                ),
                repeatingSubitem: item,
                count: 2
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }, configuration: configuration)
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HPShop>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration {
                SearchCell(title: item.name, detail: item.address, imageURL: item.photo.mobile?.large)
            }
            
            return cell
        }
    }
    
    @objc func searchGourmet(at location: CLLocation) {
        gourmetSearch.search(at: location.coordinate, range: searchRange) { shops, error in
            if error != nil { return }
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
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < collectionView.numberOfItems(inSection: 0) {
            performSegue(withIdentifier: "toDetail", sender: dataSource.itemIdentifier(for: indexPath))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destination = segue.destination as? RestaurantDetailViewController,
               let shop = sender as? HPShop {
                destination.hpShop = shop
            }
        }
    }
    
}
