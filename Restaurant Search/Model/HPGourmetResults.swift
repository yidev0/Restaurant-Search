//
//  HPGourmetResults.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/25.
//

import Foundation

struct HPGourmetResults: Decodable {
    
    let results: HPGourmetShop
    
}

extension HPGourmetResults {
    
    var shops: [HPShop] {
        return self.results.shops
    }
    
}
