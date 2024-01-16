//
//  LottoAPIManager.swift
//  NetworkPractice
//
//  Created by Greed on 1/16/24.
//

import Foundation
import Alamofire

struct Lotto: Codable {
    let drwNo: Int //회차
    let drwNoDate: String //날짜
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

struct LottoAPIManager {
    
    func callRequset(number: String, completionhandler: @escaping (Lotto) -> Void) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            
            switch response.result {
            case .success(let success):
                print(success)
                
                completionhandler(success)
            
            case .failure(let failure):
                print("통신 오류")
            }
            
        }
        
    }
}
