//
//  ThirdViewController.swift
//  ScreenChangeExample
//
//  Created by 박솔미 on 2022/07/18.
//

import UIKit //Foundation(X) : Swift앱을 만들 때는 UIKit를 import한다.

//UIViewController의 상속을 받음
class ThirdViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var label_text = "" //화면 구성 전에도 label값을 바꿀 수 있도록 초기화를 미리 해 둠
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("Third View Init")
    }
    
    //View가 나타날 때 이벤트 처리
    override func viewDidAppear(_ animated: Bool) {
        //self.label.text = self.label_text
    }
    
    //화면이 뜨려고 할 때 이벤트 처리 (viewDidAppear보다 더 빠른 시점)
    override func viewWillAppear(_ animated: Bool) {
        self.label.text = self.label_text
    }
    
    //뒤로 가기 누를 때 화면 스택 쌓이지 않고 뒤로가도록 처리
    //화면 스택이 계속 쌓이면 -> 메모리 부족 발생
    @IBAction func goBack(_ sender: Any) {
        //현재 화면(나)을 띄워준 ViewController가 있는지? -> 있으면 이전 화면으로 갈 수 있음.
        if let preVC = self.presentingViewController as? UIViewController {
            //NSLog("get pre view controller") -> (테스트)실행 잘 됨 : ViewController를 잘 찾았다는 의미
            
            //이전 화면의 dismiss : 창이 뜬 것을 없애겠다는 함수
            //animated(애니메이션 안 넣음), completion(전환 후 할 일)
            preVC.dismiss(animated: false, completion: nil)
            
            
        }
    }
    
}
