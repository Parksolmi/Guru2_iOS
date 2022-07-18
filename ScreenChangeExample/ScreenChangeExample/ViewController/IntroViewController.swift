//
//  IntroViewController.swift
//  ScreenChangeExample
//
//  Created by 박솔미 on 2022/07/18.
//

import UIKit

class IntroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //화면 구성 후 이벤트 처리
    override func viewDidAppear(_ animated: Bool) {
        NSLog("view appear")
        
        //스토리 보드가 있을 때 실행
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "firstScreen")
            
            //화면 띄우기
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
