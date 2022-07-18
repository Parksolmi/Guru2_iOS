//
//  IntroViewController.swift
//  BasicSequence
//
//  Created by 박솔미 on 2022/07/19.
//

import UIKit
import SwiftyGif

class IntroViewController: UIViewController {
    
    @IBOutlet weak var intro_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            
            let gif = try UIImage(gifName: "intro.gif")
            self.intro_image.setGifImage(gif, loopCount: 1) //-1은 무한재생
            self.intro_image.delegate = self //delegate연결
            
        } catch {
            NSLog("재생불가")
        }
        
        //로딩이 필요한 정보가 있다면 이때 로드를 완료하고
        //화면을 전달한다.
    }
    
    //화면이 나타난 후
    override func viewDidAppear(_ animated: Bool) {
        
        //몇(3)초 후에 화면을 전환하겠다.
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            
            /*
            //스토리보드가 있다면 화면을 전환하겠다.
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
             */
            
            self.goMainView()
        }
    }
    
    
}

extension IntroViewController:SwiftyGifDelegate {
    
    func gifDidStop(sender: UIImageView) {
            print("gifDidStop")
    }
    
    func goMainView() {
        
        //스토리보드가 있다면 화면을 전환하겠다.
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
