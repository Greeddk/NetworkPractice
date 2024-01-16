//
//  ViewController.swift
//  NetworkPractice
//
//  Created by Greed on 1/16/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var userTextField: UITextField!
    
    @IBOutlet var lottoBallView: [UIView]!
    @IBOutlet var bonusNumLabel: UILabel!
    
    @IBOutlet var numberBackView: [UIView]!
    @IBOutlet var lottoNum: [UILabel]!
    
    var ballColor: [UIColor] = [.red, .blue, .green, .orange, .purple, .black, .brown]
    var lottoRounds: Lotto = Lotto(drwNo: 0, drwNoDate: "", drwtNo1: 0, drwtNo2: 0, drwtNo3: 0, drwtNo4: 0, drwtNo5: 0, drwtNo6: 0, bnusNo: 0)
    var roundsList: [Int] = Array(1...1102).reversed()
    var lottoPickerView = UIPickerView()
    
    var lottoManager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        lottoManager.callRequset(number: "\(roundsList[0])") { value in
            self.lottoRounds = value
            self.setUI()
        }
        
    }


}

extension ViewController { //UI
    
    func setUI() {
        
        ballColor.shuffle()
        
        for index in 0...lottoBallView.count - 1 {
            
            let lottoBall = lottoBallView[index]
            let ballNum = lottoNum[index]
            let backView = numberBackView[index]
            
            backView.backgroundColor = .white
            backView.layer.cornerRadius = backView.frame.width / 2
            
            lottoBall.backgroundColor = ballColor[index]
            
            lottoBall.layer.cornerRadius = lottoBall.frame.width / 2
        
            ballNum.textColor = .black
            ballNum.textAlignment = .center
            
        }
        
        lottoNum[0].text = "\(lottoRounds.drwtNo1)"
        lottoNum[1].text = "\(lottoRounds.drwtNo2)"
        lottoNum[2].text = "\(lottoRounds.drwtNo3)"
        lottoNum[3].text = "\(lottoRounds.drwtNo4)"
        lottoNum[4].text = "\(lottoRounds.drwtNo5)"
        lottoNum[5].text = "\(lottoRounds.drwtNo6)"
        lottoNum[6].text = "\(lottoRounds.bnusNo)"
        
        userTextField.textAlignment = .center
        userTextField.text = "회차: \(lottoRounds.drwNo)차"
        userTextField.inputView = lottoPickerView
        
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let round = roundsList[row]
        lottoManager.callRequset(number: "\(round)") { value in
            self.lottoRounds = value
            self.userTextField.text = "회차: \(value.drwNo)차"
            self.lottoNum[0].text = "\(value.drwtNo1)"
            self.lottoNum[1].text = "\(value.drwtNo2)"
            self.lottoNum[2].text = "\(value.drwtNo3)"
            self.lottoNum[3].text = "\(value.drwtNo4)"
            self.lottoNum[4].text = "\(value.drwtNo5)"
            self.lottoNum[5].text = "\(value.drwtNo6)"
            self.lottoNum[6].text = "\(value.bnusNo)"
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(roundsList[row])회차"
    }
    
}

