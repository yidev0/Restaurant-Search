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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.sizeToFit()
        
        self.navigationItem.searchController = searchController
        
        configureCollectionView()
        configureDataSource()
        loadData()
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
    
    func loadData() {
        // TODO: Apply current location
        // temp: tokyo station
        gourmetSearch.search(at: CLLocationCoordinate2D(latitude: 35.68204, longitude: 139.76468)) { shops, error in
            var snapshot = NSDiffableDataSourceSnapshot<Section, HPShop>()
            snapshot.appendSections([.main])
            
            let items = shops
            snapshot.appendItems(items, toSection: .main)
            
            DispatchQueue.main.async {
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
        }
    }
    
}
