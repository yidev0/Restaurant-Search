//
//  GourmetSearch.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/06/25.
//

import Foundation
import CoreLocation

class HPGourmetSearch {
    
    enum HPGourmetSearchError: Error {
        case timeInterval
        case notURL
    }
    
    // TODO: API Key
    private let apiKey = ""
    
    public var urlTask: URLSessionTask?
    
    private var lastAPICall: Date?
    private var apiInterval: TimeInterval = 10
    
    func search(at coordiante: CLLocationCoordinate2D, range: Int = 3, completion: @escaping ([HPShop], Error?) -> Void) {
        if Date().timeIntervalSince(lastAPICall ?? Date()) > apiInterval || lastAPICall == nil {
            setTimeStamp()
        } else {
            completion([], HPGourmetSearchError.timeInterval)
            return
        }
        
        var urlString: String {
            let base = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)"
            return base + "&lat=\(coordiante.latitude)&lng=\(coordiante.longitude)" + "&range=\(range)" + "&count=5" + "&format=json"
        }
        
        guard let url = URL(string: urlString) else {
            completion([], HPGourmetSearchError.notURL)
            return
        }
        
        urlTask = URLSession.shared.dataTask(with: url) { (data, result, error) in
            if let data = data {
                do {
                    print("searched", coordiante)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(HPGourmetResults.self, from: data)
                    completion(result.shops, error)
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
    
    private func setTimeStamp() {
        lastAPICall = Date()
    }
    
}
