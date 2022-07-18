//
//  SecondViewController.swift
//  ScreenChangeExample
//
//  Created by 박솔미 on 2022/07/18.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //화면이 넘어가기 전에 이벤트 처리
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NSLog("prepare segue")
        
        if let destination = segue.destination as? ThirdViewController {
            destination.label_text = "test"
        }
    }
}
