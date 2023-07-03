//
//  SearchCollectionViewCell.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/07/03.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage(of url: URL?) {
        if let url = url {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error { print(error.localizedDescription); return; }
                
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
    }

}
