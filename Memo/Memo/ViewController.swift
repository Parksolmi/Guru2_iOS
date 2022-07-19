//
//  ViewController.swift
//  Memo
//
//  Created by 박솔미 on 2022/07/12.
//

import UIKit
import FMDB

class ViewController: UIViewController {

    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //메모 내용 기록
    var memoArray = Array<String>()
    //데이터베이스 파일 경로를 저장하는 변수
    var dbPath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터베이스 초기화
        initDB()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //DB에 저장한 메모 내용 tableView에 Load하기
        let db = FMDatabase(path: dbPath)
        
        if db.open() {
            let queryToLoad = "select * from memoTB"
            if let result = db.executeQuery(queryToLoad, withArgumentsIn: []) {
                
                while result.next() {
                    memoArray.append(String(result.string(forColumn: "memotxt")!))
                }
            
            self.tableView.reloadData()
                
            } else {
                NSLog("결과 없음")
            }
        } else {
            NSLog("DB Connection Error")
        }
    }
    
    
    //데이터베이스 초기화 함수
    func initDB() {
        //iOS파일 접근을 위한 파일 매니저 인스턴스 생성
        let fileMgr = FileManager.default
        //iOS에 파일 기록을 위해 앱마다 지정된 경로를 찾음. 배열로 반환.
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        
        dbPath = docDir + "/memo.db"
        
        //파일 매니저 존재X == db파일이 생성이 되지 않았다는 의미
        if !fileMgr.fileExists(atPath: dbPath) {
            //DB만들기
            let db = FMDatabase(path: dbPath)
            if db.open() {
                let query = "create table if not exists memoTB (id integer primary key autoincrement, memotxt text)"
                if !db.executeStatements(query) {
                    NSLog("디비 생성 실패")
                } else {
                    NSLog("디비 생성 성공")
                }
            }
        }
        else {
            NSLog("DB파일있음")
        }
    }

     
    
    //save버튼 동작 함수
    @IBAction func doSave(_ sender: Any) {
        
        
        //메모 내용 array에 넣기
        if let memo = textfield.text /*, let _ = String?(memo) */ {
            
            memoArray.append(memo)
            
            //DB에 메모 저장하기
            let db = FMDatabase(path: dbPath)
            if db.open() {
                
                //메모 내용 db에 넣기
                let queryToInsert = "insert into memoTB(memotxt) values ('\(memo)')"
                    
                    if !db.executeUpdate(queryToInsert, withArgumentsIn: []) {
                        NSLog("저장 실패")
                    } else {
                        NSLog("저장 성공")
                    }
                
                } else {
                    NSLog("DB Connection Error")
                }
        }
        
    //save이후 이벤트 처리
    textfield.resignFirstResponder()
    textfield.text = "" //다른방법?
    
    //데이터 새로 로드
    self.tableView.reloadData()
    }
    
}

//tableView에 memoArray내용 띄우기
extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! MemoCell
        
        cell.label.text = memoArray[indexPath.row]
        
        return cell
    }
}
