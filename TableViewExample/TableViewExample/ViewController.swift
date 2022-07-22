//
//  ViewController.swift
//  TableViewExample
//
//  Created by 박솔미 on 2022/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var memoText: UITextField!
    
    var dataSource:[String] = []
    // var dataSource = [String]()
    

    //뷰 인스턴스가 메모리에 올라왔지만 화면은 띄우지 않은 상황
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //update table content : 인터넷에서 데이터를 가져올 때
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .cyan //색변경
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        //userDefault에 저장된 데이터 불러오기
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "MemoData") as? [String] {
            self.dataSource = value
        }
    }
    @objc func fetchData(_ sender:Any) {
        tableView.refreshControl?.endRefreshing()
    }
    
    //네비게이션 바 숨기기 & 보이기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    // 버튼 이벤트
    // Edit버튼
    @IBAction func changeEditing(_ sender: UIBarButtonItem) {
        
        //isEditing : editing mode를 설정할 수 있는 변수.
         
        //self.tableView.isEditing = !self.tableView.isEditing //방법1
        self.tableView.isEditing.toggle() //방법2
    }
    
    // +버튼
    @IBAction func addMemo(_ sender: Any) {
        
        //메모가 비어있으면 아무 이벤트가 일어나지 않도록
        guard let memo = memoText.text, memo != "" else{
            return
        }
        
        //변수에 저장하기
        self.dataSource.append(memo)
        memoText.text = ""
        
        //UserDefault에 저장하기
        self.saveData()
        
        memoText.resignFirstResponder()
        tableView.reloadData()
    }
    
    func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(dataSource, forKey: "MemoData")
        userDefault.synchronize()
    }
    
}



extension ViewController: UITableViewDataSource {
    
    //테이블뷰에 몇 개의 줄을 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    //해당 줄에 어떤 내용을 넣을 것인지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! memoCell
        let row = indexPath.row
        cell.memoLabel.text = "\(dataSource[row])"
        cell.numLabel.text = "\(row+1)"
        return cell
    }
    
    //해당 줄이 편집이 가능한지 제어하는 함수(:canEditRowAt)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        //let row = indexPath.row
        //dataSource[row].isMine == true 내가 쓴 글만 삭제하는 기능을 넣을 때
        //return row % 2 == 0 //홀수만 삭제 가능
        return true //모든 셀이 편집 가능
    }
    
    //tableview의 셀이 움질일 수 있게 하는 함수(:canMoveAt)
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPathL: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPathL.row
        let toRow = destinationIndexPath.row
        let data = dataSource[fromRow]
        dataSource.remove(at: fromRow)
        dataSource.insert(data, at: toRow)
        saveData()
        
        tableView.reloadData()
    }
}



extension ViewController : UITableViewDelegate {
    
    //editingStyle아이콘
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    //indent를 줄지 말지 설정하는 함수
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    //셀에서 스와이프를 했을 때, 셀 오른쪽 끝에 나타날 버튼을 지정하는 함수
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //수정버튼 구현
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completion) in
            
            //수정 이벤트 구현
            let editAlert = UIAlertController(title: "Edit Memo", message: "change your memo", preferredStyle: .alert)
            
            editAlert.addTextField { (textField) in
                textField.text = self?.dataSource[indexPath.row]
            }
            
            editAlert.addAction(UIAlertAction(title: "Modify", style: .default, handler: { (action) in
                
                if let fields = editAlert.textFields, let textField = fields.first, let text = textField.text {
                    
                    //dataSource의 데이터 업데이트
                    self?.dataSource[indexPath.row] = text
                    // self!.tableView.reloadData() //전체 페이지를 reload
                    self?.tableView.reloadRows(at: [indexPath], with: .fade) //해당 줄 만 reload
                    
                    self?.saveData()
                }
            }))
            //cancel버튼
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(editAlert, animated: true, completion: nil)
            
            completion(true)
        }
        
        //삭제버튼 구현
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { [weak self] (action, view, completion) in
            
            //삭제 이벤트 구현
            let row = indexPath.row
            self?.dataSource.remove(at: row)
            //tableView.deleteRows(at: [indexPath], with: .fade) //reload로도 구현 가능함.
            tableView.reloadData()
            self?.saveData()
            
            completion(true)
        }
        
        btnEdit.backgroundColor = .blue
        btnDelete.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [btnDelete, btnEdit])
    }
    
    
    //셀 왼쪽에 나타날 버튼을 구현해주는 함수
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //공유버튼 구현
        let btnShare = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [btnShare])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //선택을 하면 선택이 풀리도록
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    //테이블 뷰 셀의 간격 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 12 //개수로 생각해서 넣을 때
    }
}
