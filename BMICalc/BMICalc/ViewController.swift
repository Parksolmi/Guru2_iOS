//
//  ViewController.swift
//  BMICalc
//
//  Created by 박솔미 on 2022/07/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var bmiField: UITextField!
    
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 3
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bmiCalculation(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText),
           let weightText = weightField.text, let weight = Double(weightText) {
            //bmi 계산
            let bmi = weight / ((height/100)*(height/100))
            bmiField.text = numberFormatter.string(from: NSNumber(value: bmi))
        }
        //weightField.resignFirstResponder()
        //heightField.resignFirstResponder()
        view.endEditing(true) //키보드 내리는 케이스 다 고려해서 코드 작성하기
    }
    
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func testEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
}

