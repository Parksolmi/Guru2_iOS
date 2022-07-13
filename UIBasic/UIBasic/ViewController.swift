//
//  ViewController.swift
//  UIBasic
//
//  Created by 박솔미 on 2022/07/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UITextField! //!는 무조건 값이 있을 것이라고 상정하는 것.
    @IBOutlet weak var label2: UITextField!
    
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("홈 화면이 나타납니다.")
    }

    @IBAction func doConvert(_ sender: UIButton) {
        if let value1 = label1.text, let number1 = Double(value1) {
            //섭씨 * 1.8 + 32 = 화씨
            let fahrenheit = number1 * 1.8 + 32
            label2.text = numberFormatter.string(from: NSNumber(value: fahrenheit)) //형변환
            label1.resignFirstResponder()
        }
        
        print("버튼이 눌렸습니다.")
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        label1.resignFirstResponder()
        label2.resignFirstResponder()
    }
    
}

