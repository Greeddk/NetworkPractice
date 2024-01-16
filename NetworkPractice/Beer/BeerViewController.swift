//
//  BeerViewController.swift
//  NetworkPractice
//
//  Created by Greed on 1/16/24.
//

import UIKit
import Kingfisher

class BeerViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerDescLabel: UILabel!
    @IBOutlet var recommendBeerButton: UIButton!
    
    var beerManager = BeerAPIManager()
    var beer: Beer = Beer(name: "", image_url: "", tagline: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        callAPI()
        
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        callAPI()
    }
    
}

extension BeerViewController {
    
    func callAPI() {
        beerManager.callRequest { value in
            self.beer = value
            self.setUI()
        }
    }
    
    func setUI() {
        
        titleLabel.text = "오늘은 이 맥주를 추천합니다!"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 26)
        
        beerNameLabel.textAlignment = .center
        beerNameLabel.font = .boldSystemFont(ofSize: 20)
        beerNameLabel.text = beer.name
        
        beerDescLabel.numberOfLines = 0
        beerDescLabel.text = "\(beer.tagline)\n\(beer.description)"
        beerDescLabel.textAlignment = .center
        
        let url = URL(string: beer.image_url)
        beerImageView.kf.setImage(with: url)
        
        recommendBeerButton.setTitle("다른 맥주 추천받기", for: .normal)
        recommendBeerButton.tintColor = .orange
    }
}
