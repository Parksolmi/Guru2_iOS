//
//  ViewController.swift
//  RectangleCalc
//
//  Created by 박솔미 on 2022/07/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var areaField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 3
        
        return nf
    }()
    
    @IBAction func doCalc(_ sender: Any) {
        if let widthTxt = widthField.text, let width = Double(widthTxt),
            let heightTxt = heightField.text, let height = Double(heightTxt) {
            
            let area = width * height
            areaField.text = numberFormatter.string(from: NSNumber(value: area))
        }
        view.endEditing(true)
        
    }
    
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func testEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    

}

