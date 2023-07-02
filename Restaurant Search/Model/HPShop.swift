//
//  HPShop.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/25.
//

import Foundation

struct HPShop: Decodable {
    
    var id: String
    var name: String
    var address: String
    var logoImage: String
    var open: String
//    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case logoImage = "logoImage"
        case open = "open"
    }
    
}
