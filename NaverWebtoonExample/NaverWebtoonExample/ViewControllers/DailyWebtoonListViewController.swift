//
//  DailyWebtoonListViewController.swift
//  NaverWebtoonExample
//
//  Created by 박솔미 on 2022/07/27.
//

import UIKit
import Parchment //화면 전환이 되는 뷰를 만들기 위해 import

class DailyWebtoonListViewController: UIViewController {
    
    var pagingViewController : PagingViewController!
    var viewControllers : [ViewController] = [] //월화수목금토일 ViewController
    let dayTitles = ["월", "화", "수", "목", "금", "토", "일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view 만들기
        for title in dayTitles {
            //화면만들기
            if let vc = storyboard?.instantiateViewController(identifier: "webtoonListView") as? ViewController {
                
                //각 viewController의 메뉴title에 dayTitles 순서대로 넣기
                vc.title = title
                viewControllers.append(vc)
            }
        }
        
        //PagingViewController 만들기
        pagingViewController = PagingViewController(viewControllers: viewControllers )
        
        //메뉴 스타일 변경
        pagingViewController.menuItemSize = .sizeToFit(minWidth: 30, height: 40)
        pagingViewController.menuItemSpacing = 0
        pagingViewController.menuItemLabelSpacing = 0
        pagingViewController.indicatorOptions = .hidden
        pagingViewController.selectedBackgroundColor = .green
        pagingViewController.selectedTextColor = .white
        
    }
    
    
    //메인 화면에서 보여주기
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        //view 띄우기
        addChild(pagingViewController)
        pagingViewController.view.frame = self.view.frame
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    
    
}
