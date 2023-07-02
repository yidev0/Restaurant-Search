//
//  HPShop.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/25.
//

import Foundation

struct HPShop: Decodable, Hashable {
    
    let id: String
    let name: String
    let address: String
    let logoImage: URL
    let open: String

    let photo: HPPhoto
    
    struct HPPhoto: Decodable, Hashable {
        let large: URL
        let medium: URL
        let small: URL
        
        private enum PhotoCodingKeys: String, CodingKey {
            case pc = "pc"
        }
        
        private enum PhotoSizeCodingKeys: String, CodingKey {
            case large = "l"
            case medium = "m"
            case small = "s"
        }
        
        init(from decoder: Decoder) throws {
            let photoContainer = try decoder.container(keyedBy: PhotoCodingKeys.self)
            let sizeContainer = try photoContainer.nestedContainer(keyedBy: PhotoSizeCodingKeys.self, forKey: .pc)
            large = try sizeContainer.decode(URL.self, forKey: .large)
            medium = try sizeContainer.decode(URL.self, forKey: .medium)
            small = try sizeContainer.decode(URL.self, forKey: .small)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case logoImage = "logoImage"
        case open = "open"
        case photo
    }
    
}
