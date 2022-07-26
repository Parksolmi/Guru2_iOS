//
//  DetailController.swift
//  AlamofireBasic
//
//  Created by 박솔미 on 2022/07/27.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailController: UIViewController {
    
    var user_id:String! //디스플레이 할 사람의 id정보
    var user_info:PersonDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getData(user_id)
    }

    func getData(_ user_id:String) {
        
        print ("start loading")
        
        //app id를 헤더에 넣기
        let headers: HTTPHeaders = [
            "app-id": "62e01e2257e68a3321e197b1"
        ]
        //서버에 데이터 요청하기
        AF.request("https://dummyapi.io/data/v1/user/\(user_id)", headers: headers).responseJSON { response in
            //debugPrint(response)
            
            switch response.result {
            case .success(let data) : //데이터를 성공적으로 읽어옴
                do {
                    //data : NSDictionary타입 이고,
                    //Data : NSData타입 이므로 타입을 맞춰주기
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    print(data)
                    
                    //디코딩
                    let decorder = JSONDecoder()
                    self.user_info = try decorder.decode(PersonDetail.self, from: jsonData)
                    self.updateInfo()
                    
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
    
    func updateInfo() {
        print("update info : ", user_info)
    }
}
