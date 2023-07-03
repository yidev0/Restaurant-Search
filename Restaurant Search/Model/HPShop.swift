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
    let access: String
    let mobileAccess: String
    let latitude: Double
    let longitude: Double
    
    let photo: Photo
    
    struct Photo: Decodable, Hashable {
        let pc: PhotoURL
        let mobile: PhotoURL?
        
        struct PhotoURL: Decodable, Hashable {
            let large: URL
            let medium: URL?
            let small: URL
            
            private enum PhotoCodingKeys: String, CodingKey {
                case large = "l"
                case medium = "m"
                case small = "s"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: PhotoCodingKeys.self)
                large = try container.decode(URL.self, forKey: .large)
                medium = try container.decodeIfPresent(URL.self, forKey: .medium)
                small = try container.decode(URL.self, forKey: .small)
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case logoImage = "logoImage"
        case open = "open"
        case photo
        case access
        case mobileAccess
        case latitude = "lat"
        case longitude = "lng"
    }
    
}
