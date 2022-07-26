//
//  BannerViewController.swift
//  NaverWebtoonExample
//
//  Created by 박솔미 on 2022/07/26.
//

import UIKit

class BannerViewController: UIViewController {
    
    let banner_images = ["banner_01", "banner_02", "banner_03", "banner_04"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 화면 너비 : 높이 = 218:120 <=> 너비*120 = 높이*218 <=> 높이 = 너비*120/218
        let screenSize = UIScreen.main.bounds // 화면의 정보
        let width = screenSize.width
        let height = width * 120 / 218
        
        //enumerated : 배열에 넣은 값을 꺼낼 때 순번(index)까지 같이 꺼내줌
        for (index, imageName) in banner_images.enumerated() {
            
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            
            //어떤 뷰의 총 크기 = frame
            imageView.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: height)
            
            //화면에 나타나도록 view 추가
            self.view.addSubview(imageView)
        }
        
        self.view.frame = CGRect(x: 0, y: 0, width: width * CGFloat(banner_images.count), height: height)
    }
    
    
    
}
