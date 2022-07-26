//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by 박솔미 on 2022/07/27.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    var person_data = [PersonInfo]()
    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    func getData() {
        
        print ("start loading")
        
        //app id를 헤더에 넣기
        let headers: HTTPHeaders = [
            "app-id": "62e01e2257e68a3321e197b1"
        ]
        //서버에 데이터 요청하기
        AF.request("https://dummyapi.io/data/v1/user?limit=10", headers: headers).responseJSON { response in
            //debugPrint(response)
            
            switch response.result {
            case .success(let data) : //데이터를 성공적으로 읽어옴
                do {
                    //data : NSDictionary타입 이고,
                    //Data : NSData타입 이므로 타입을 맞춰주기
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decorder = JSONDecoder()
                    let dummy_data = try decorder.decode(DummyData.self, from: jsonData)
                    
                    self.person_data = dummy_data.data
                    self.personCollectionView.reloadData()
                    
                    print("finish parsing")
                } catch {
                    debugPrint(error)
                }
                
            case .failure(let data) :
                print("fail")
            default:
                return
            }
        }
        
        //finish loading이 finish parsing보다 먼저 뜨는 이유 : 비동기 동작
        print("finish loading")
    }
    
    //현재 select된 cell이 가진 정보 중 id를 가져와서 user_id에 할당
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("selected items", self.personCollectionView.indexPathsForSelectedItems)
        
        if let indexPath = self.personCollectionView.indexPathsForSelectedItems?.first {
            let person_info = person_data[indexPath.row]
            
            if let vc = segue.destination as? DetailController {
                vc.user_id = person_info.id
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        
        let data = person_data[indexPath.row]
        
        if let url = data.picture {
            cell.profileImage.af.setImage(withURL: url)
        }
        cell.idLabel.text = data.id
        cell.nameLabel.text = data.firstName
        cell.emailLabel.text = "email"
        
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    //셀 간격 -> estimate size를 none으로 바꾸는 것 잊지 말기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //셀의 사이즈 정하기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width-20) / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

