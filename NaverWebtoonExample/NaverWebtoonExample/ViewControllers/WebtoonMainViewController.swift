//
//  BannerViewController.swift
//  NaverWebtoonExample
//
//  Created by 박솔미 on 2022/07/26.
//

import UIKit

class WebtoonMainViewController: UIViewController {
    
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerViewController = BannerViewController()
        
        //화면에 표시되도록 넣어주기
        bannerScrollView.addSubview(bannerViewController.view)
        //스크롤이 가능하도록 콘텐츠 사이즈 설정
        bannerScrollView.contentSize = bannerViewController.view.frame.size
    }
}
