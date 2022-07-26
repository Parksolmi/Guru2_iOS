//
//  ViewController.swift
//  NaverWebtoonExample
//
//  Created by 박솔미 on 2022/07/22.
//

import UIKit

class ViewController: UIViewController {

    //var titleImages = ["title_01", "title_02", "title_03", "title_04", "title_05", "title_06"]
    
    var webtoonData = [
        WebtoonData("독립일기", "title_01", 9.97, "자까"),
        WebtoonData("윈드브레이커", "title_02", 9.84, "조용석"),
        WebtoonData("소녀의 세계", "title_03", 9.93, "모랑지"),
        WebtoonData("홍시는 날 좋아해!", "title_04", 9.97, "강하다/웃는해"),
        WebtoonData("조조코믹스", "title_05", 9.97, "이동건"),
        WebtoonData("이번 생도 잘 부탁해", "title_06", 9.98, "이혜")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return titleImages.count
        return webtoonData.count * 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webToonCell", for: indexPath) as! WebtoonCell
        
        // title, 별점, 작가명 채우기
        let data = webtoonData[indexPath.row % 6]
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "\(data.rating!)"
        cell.authorLabel.text = data.author
        
        //타이틀 이미지 변경
        //cell.titleImage.image = UIImage(named: titleImages[indexPath.row])
        cell.titleImage.image = UIImage(named: data.title_image)
        
        //레이어 테두리 두께 정하기
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    //사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let width = self.view.frame.size.width / 3
        let width = UIScreen.main.bounds.width / 3
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
}
