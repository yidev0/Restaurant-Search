//
//  GourmetSearch.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/25.
//

import Foundation
import CoreLocation

class HPGourmetSearch {
    
    // TODO: API Key
    private let apiKey = ""
    
    public var urlTask: URLSessionTask?
    
    func search(coordiante: CGPoint, completion: @escaping ([HPShop], Error?) -> Void) {
        let urlString = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)&lat=\(coordiante.x)&lng=\(coordiante.y)&count=5&format=json"
        
        guard let url = URL(string: urlString) else {
            completion([], nil)
            return
        }
        
        urlTask = URLSession.shared.dataTask(with: url) { (data, result, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(HPGourmetResults.self, from: data)
                    autoreleasepool {
                        completion(result.shops, error)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion([], error)
                }
            } else {
                completion([], error)
            }
        }
        
        urlTask?.resume()
    }
    
}
