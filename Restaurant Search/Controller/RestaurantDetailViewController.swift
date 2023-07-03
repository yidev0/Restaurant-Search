//
//  RestaurantDetailViewController.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/07/02.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var hpShop: HPShop!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var accessLabel: UILabel!
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupImage()
    }
    
    func setupLabels() {
        self.nameLabel.text = hpShop.name
        self.nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        self.nameLabel.numberOfLines = 0
        
        self.addressLabel.text = hpShop.address
        self.addressLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.addressLabel.numberOfLines = 0
        self.addressLabel.accessibilityLabel = "Address".localize()
        self.addressLabel.accessibilityValue = hpShop.address
        
        self.accessLabel.text = hpShop.access
        self.accessLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.accessLabel.numberOfLines = 0
        self.accessLabel.accessibilityLabel = "Access".localize()
        self.accessLabel.accessibilityValue = hpShop.access
        
        self.hoursLabel.text = hpShop.open
        self.hoursLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.hoursLabel.textColor = UIColor.secondaryLabel
        self.hoursLabel.numberOfLines = 0
        self.hoursLabel.accessibilityLabel = "OpenHours".localize()
        self.hoursLabel.accessibilityValue = hpShop.open
    }
    
    func setupImage() {
        thumbnailImage.isAccessibilityElement = false
        thumbnailImage.accessibilityIgnoresInvertColors = true
        
        if let url = hpShop.photo.mobile?.large {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error { print(error.localizedDescription); return; }
                
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        self.thumbnailImage.image = image
                    }
                }
            }.resume()
        }
    }
    
}
