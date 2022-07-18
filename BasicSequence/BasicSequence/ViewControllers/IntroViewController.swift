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
            self.intro_image.setGifImage(gif, loopCount: -1) //-1은 무한재생
            
        } catch {
            NSLog("재생불가")
        }
    }
    
    
}
