//
//  NetworkManager.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import Foundation

class JSONDownloader {
    
    let session = URLSession.shared
    
    func getFishingTrip(completion: @escaping ([FishingTrip]?, NetworkError?) -> Void) {
        guard let url = URL(string: "https://liquid.fish/fishes.json") else {
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse  else {
                    completion(nil, .responseFailed)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        completion(nil, .dataNotFound)
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let fishingTrips = try decoder.decode([FishingTrip].self, from: data)
                        completion(fishingTrips, nil)
                    } catch {
                        print(String(data: data, encoding: .utf8)!)
                        completion(nil, .invalidData)
                    }
                } else {
                    // Response is not 200
                    completion(nil, .responseFailed)
                }
            }
        }.resume()
    }
    
    func postFishNumber(email: String, fishType: String, total: Int, month: Month, completion: @escaping (Bool, NetworkError?) -> Void) {
        guard let url = URL(string: "https://en9zbp36b1sxt.x.pipedream.net") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse  else {
                    completion(false, .responseFailed)
                    return
                }
                
                if response.statusCode == 200 {
                    completion(true, nil)
                } else {
                    // Response is not 200
                    completion(false, .responseFailed)
                }
            }
        }.resume()
    }
    
}
