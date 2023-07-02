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
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    func setupLabels() {
        self.nameLabel.text = hpShop.name
        self.nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        self.nameLabel.numberOfLines = 0
        
        self.addressLabel.text = hpShop.address
        self.addressLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.addressLabel.numberOfLines = 0
        
        self.hoursLabel.text = hpShop.open
        self.hoursLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.hoursLabel.textColor = UIColor.secondaryLabel
        self.hoursLabel.numberOfLines = 0
    }

}
