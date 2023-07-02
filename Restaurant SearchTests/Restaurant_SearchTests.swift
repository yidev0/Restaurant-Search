//
//  Restaurant_SearchTests.swift
//  Restaurant SearchTests
//
//  Created by Yuto on 2023/06/25.
//

import XCTest
@testable import Restaurant_Search

final class Restaurant_SearchTests: XCTestCase {

    // TODO: API Key
    private let apiKey = ""
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGourmetFetch() {
        let urlString = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=sample&large_area=Z011"
        let expectation = expectation(description: "Gourmet Fetched")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, result, error) in
            if data != nil {
                expectation.fulfill()
            }
        }.resume()
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGourmetSearchLocal() {
        let expectation = expectation(description: "Gourmet Loaded")
        let data = Data(jsonSample.utf8)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(HPGourmetResults.self, from: data)
            if result.shops.count == 5 {
                expectation.fulfill()
            }
        } catch {
            fatalError()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGourmetSearch() {
        if apiKey == "" { XCTAssertFalse(true); return }
        let urlString = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)&lat=34.67&lng=135.52&count=5&format=json"
        let expectation = expectation(description: "Gourmet Fetched")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, result, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(HPGourmetResults.self, from: data)
                    if result.shops.count == 5 {
                        expectation.fulfill()
                    }
                } catch {
                    fatalError()
                }
            }
        }.resume()
        
        wait(for: [expectation], timeout: 5)
    }

}
