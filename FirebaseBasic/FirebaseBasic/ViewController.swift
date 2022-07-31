//
//  ViewController.swift
//  FirebaseBasic
//
//  Created by 박솔미 on 2022/07/31.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class ViewController: UIViewController, FUIAuthDelegate {
    
    var handle: AuthStateDidChangeListenerHandle!
    let authUI = FUIAuth.defaultAuthUI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //firebase UI 초기화
        authUI!.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //handle 변수 초기화
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let currentUser = auth.currentUser {
                //로그인 된 상태
                NSLog("Logged In")
                
                //로그인 되었을 때 alert창 띄우기
                if let displayName = currentUser.displayName {
                    let alertController = UIAlertController(title: "Welcome", message: "\(displayName)! Welcome:)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alertController, animated: false, completion: nil)
                }
                
                
            } else {
                //로그아웃 된 상태
                NSLog("Logged Out")
                
                //firebase UI 구성
                let providers: [FUIAuthProvider] = [
                    //이메일로 로그인하기
                    FUIEmailAuth(),
                ]
                self.authUI!.providers = providers
                
                
                //view controller 띄우기
                let authVC = self.authUI!.authViewController()
                authVC.modalPresentationStyle = .fullScreen
                
                //네비게이션 바 숨기기
                //authVC.setNavigationBarHidden(true, animated: false)
                
                self.present(authVC, animated: false, completion: nil)
                
                
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        //다른 창에서는 로그인 화면을 띄우지 않도록 리스너 분리
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    //로그아웃 버튼 동작
    @IBAction func doSignOut(_ sender: Any) {
        
        do {
            try authUI?.signOut()
        } catch {
            print("로그아웃 에러")
        }
    }
    
    
}

extension FUIAuthBaseViewController {
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //왼쪽 cancel버튼 없애기
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    /*
     open override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     
     self.navigationController?.setNavigationBarHidden(false, animated: false)
     }
     */
    
}
