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
        self.addressLabel.text = hpShop.address
        self.hoursLabel.text = hpShop.open
    }

}
