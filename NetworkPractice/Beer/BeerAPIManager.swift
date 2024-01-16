//
//  BeerAPIManager.swift
//  NetworkPractice
//
//  Created by Greed on 1/16/24.
//

import Foundation
import Alamofire

struct Beer: Codable {
    var name: String
    var image_url: String
    var tagline: String
    var description: String
}

struct BeerAPIManager {
    
    func callRequest(completionhandler: @escaping (Beer) -> Void) {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let success):
                print(success)
                
                completionhandler(success[0])
                
            case .failure(let failure):
                print("통신 오류")
            }
            
        }
        
        
    }
    
}
