//
//  SecondViewController.swift
//  NavigationBarBasic
//
//  Created by 박솔미 on 2022/07/18.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Test2"
    }
}
