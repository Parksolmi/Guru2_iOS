//
//  ViewController.swift
//  LottoDraw
//
//  Created by 박솔미 on 2022/07/12.
//

import UIKit
import FMDB  //pod의 강점!!!-sql write V / coredata

class ViewController: UIViewController {
    //var(:변수) 값을 수정할 수 있음. let(:상수) 값을 수정할 수 없음
    //let test_data = [1, 2, 3, 4, 5]
    //var lottoNumbers = [[1,2,3,4,5,6,],[7,8,9,10,11,12]]
    
    var lottoNumbers = Array<Array<Int>>()
    var databasePath = String() //데이터베이스 파일의 경로
    
    @IBOutlet weak var tableView: UITableView!
    
    //해당 화면이 로드가 다 되고 나면 처음에 뭘 할지 결정하는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 데이터베이스 초기화
        initDB()
    }
    
    func initDB() {
        let fileMgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        
        databasePath = docDir + "/lotto.db"
        if !fileMgr.fileExists(atPath: databasePath) {
            //DB만들기
            let db = FMDatabase(path: databasePath)
            if db.open() { //파일이 있어야 오픈이 됨.
                //테이블 생성
                //SQL : 질의문
                //메모장을 만든다면? 글자 저장을 위해 컬럼 int를 text타입으로 변경.
                let query = "create table if not exists lotto (id integer primary key autoincrement, num1 integer, num2 integer, num3 integer, num4 integer, num5 integer, num6 integer)"
                if !db.executeStatements(query) {
                    NSLog("디비 생성 실패")
                } else {
                    NSLog("디비 생성 성공")
                }
            }
        }
        else {
            NSLog("DB파일 있음")
        }
    }

    @IBAction func doLoad(_ sender: Any) {
        lottoNumbers = Array<Array<Int>>()
        let db = FMDatabase(path: databasePath)
        if db.open() {
            let query = "select * from lotto"
            if let result = db.executeQuery(query, withArgumentsIn: []) {
                
                while result.next() {
                    var columnArray = Array<Int>()
                    columnArray.append(Int(result.int(forColumn: "num1")))
                    columnArray.append(Int(result.int(forColumn: "num2")))
                    columnArray.append(Int(result.int(forColumn: "num3")))
                    columnArray.append(Int(result.int(forColumn: "num4")))
                    columnArray.append(Int(result.int(forColumn: "num5")))
                    columnArray.append(Int(result.int(forColumn: "num6")))
                    
                    lottoNumbers.append(columnArray)
                }
                self.tableView.reloadData()
            } else {
                NSLog("결과 없음")
            }
        } else {
            NSLog("DB Connection Error")
        }
    }
    
    @IBAction func doDraw(_ sender: Any) {
        lottoNumbers = Array<Array<Int>>()
        
        var originalNumbers = Array(1...45)
        var index = 0
        
        for _ in 0...4 {
            originalNumbers = Array(1...45)
            var columnArray = Array<Int>()
            for _ in 0...5 {
                index = Int.random(in: 0..<originalNumbers.count)
                columnArray.append(originalNumbers[index])
                originalNumbers.remove(at: index)
            }
            columnArray.sort()
            lottoNumbers.append(columnArray)
        }
        //데이터 다시 로드
        self.tableView.reloadData()
    }

    @IBAction func doSave(_ sender: Any) {
        let db = FMDatabase(path: databasePath)
        if db.open() {
            try! db.executeUpdate("delete from lotto", values: [])
            for numbers in lottoNumbers {
                let query = "insert into lotto(num1, num2, num3, num4, num5, num6) values (\(numbers[0]),\(numbers[1]),\(numbers[2]),\(numbers[3]),\(numbers[4]),\(numbers[5]))"
                
                if !db.executeUpdate(query, withArgumentsIn: []) {
                    NSLog("저장 실패")
                } else {
                    NSLog("저장 성공")
                }
            }
            
        } else {
            NSLog("DB Connection Error")
        }
    }
    
    
}

//datasource연결
//extension은 내용을 분리하기 위해 선언 (변수를 선언할 수는 X, 메소드만 정의)
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 셀이 몇개인지 설정하는 함수
        return self.lottoNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀에 내용을 넣어서 반환해주는 함수
        
        //let cell = UITableViewCell()
        //스토리보드에 수정한 셀 형식 가져오기 : dequeueResuableCell(메모리의 효율적인 사용)
        let cell = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for:indexPath) as! LottoCell
        let numbers = self.lottoNumbers[indexPath.row]
        
        cell.label01.text = "\(numbers[0])"
        cell.label02.text = "\(numbers[1])"
        cell.label03.text = "\(numbers[2])"
        cell.label04.text = "\(numbers[3])"
        cell.label05.text = "\(numbers[4])"
        cell.label06.text = "\(numbers[5])"
        
        return cell
    }
}

