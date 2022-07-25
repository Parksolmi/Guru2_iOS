//
//  ViewController.swift
//  MyMusicList
//
//  Created by 박솔미 on 2022/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var singerText: UITextField!
    @IBOutlet weak var songText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = Array<Array<String>>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //userDefualt에 저장된 데이터 불러오기
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "MusicData") as? [[String]] {
            self.dataSource = value
        }
    }
    
    //데이터 저장 함수
    func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(dataSource, forKey: "MusicData")
        userDefault.synchronize()
    }
    
    //네비게이션 바
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // +버튼 이벤트
    @IBAction func addMusic(_ sender: Any) {
        
        guard let singer = singerText.text, let title = songText.text,
                singer != "", title != "" else {
            return
        }
        
        var columnArray = Array<String>()
        
        columnArray.append(singer)
        columnArray.append(title)
        
        self.dataSource.append(columnArray)
        
        //UserDefault에 저장하기
        self.saveData()
        
        singerText.text = ""
        songText.text = ""
        
        singerText.resignFirstResponder()
        songText.resignFirstResponder()
        tableView.reloadData()
    }
    
    // Edit버튼 이벤트
    @IBAction func changeEditing(_ sender: Any) {
        self.tableView.isEditing.toggle()
    }
    
}



extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicListCell
        let music = self.dataSource[indexPath.row]
        
        cell.label01.text = "\(music[0])"
        cell.label02.text = "\(music[1])"
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    //Editing 모드
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //셀 선택 시, 상세페이지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    //셀 스와이프 이벤트
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //삭제버튼
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { [weak self] (action, view, completion) in
            
            let row = indexPath.row
            self?.dataSource.remove(at: row)
            tableView.reloadData()
            
            //UserDefault에 저장하기
            self?.saveData()
            
            completion(true)
        }
        
        //수정버튼
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completion) in
            
            let editAlert = UIAlertController(title: "Edit List", message: "change your music list", preferredStyle: .alert)
            
            editAlert.addTextField { (textfield1) in
                textfield1.text = self?.dataSource[indexPath.row][0]
            }
            editAlert.addTextField { (textfield2) in
                textfield2.text = self?.dataSource[indexPath.row][1]
            }
            
            editAlert.addAction(UIAlertAction(title: "Modify", style: .default, handler: { (action) in
                
                if let fields = editAlert.textFields, let textField1 = fields[0].text, let textField2 = fields[1].text {
                    
                    var columnArray = Array<String>()
                    
                    columnArray.append(textField1)
                    columnArray.append(textField2)
                    
                    //dataSource의 데이터 업데이트
                    self?.dataSource[indexPath.row] = columnArray
                    self?.tableView.reloadRows(at: [indexPath], with: .fade) //해당 줄 만 reload
                    
                    //UserDefault에 저장하기
                    self?.saveData()
                    
                }
            }))
            
            //cancel버튼
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(editAlert, animated: true, completion: nil)
            
            completion(true)
            
        }
        
        btnDelete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [btnDelete, btnEdit])
    }
    
}



