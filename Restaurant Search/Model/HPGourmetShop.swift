//
//  HPGourmetShop.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/25.
//

import Foundation

struct HPGourmetShop: Decodable {
    
    let shops: [HPShop]
    
    private enum CodingKeys: String, CodingKey {
        case shops = "shop"
    }
    
}
