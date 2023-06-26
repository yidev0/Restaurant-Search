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
    
    func search(at coordiante: CLLocationCoordinate2D, range: Int = 3, completion: @escaping ([HPShop], Error?) -> Void) {
        var urlString: String {
            let base = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)"
            return base + "&lat=\(coordiante.latitude)&lng=\(coordiante.longitude)" + "&range=\(range)" + "&count=5" + "&format=json"
        }
        
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
