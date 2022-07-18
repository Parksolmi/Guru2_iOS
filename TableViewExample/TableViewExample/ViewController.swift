//
//  ViewController.swift
//  TableViewExample
//
//  Created by 박솔미 on 2022/07/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = [1, 2, 3, 4, 5]
    
    //테이블뷰에 몇 개의 줄을 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    //해당 줄에 어떤 내용을 넣을 것인지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        cell.textLabel?.text = "\(dataSource[row])"
        return cell
    }
    
    
    //해당 줄이 편집이 가능한지 제어하는 함수(:canEditRowAt)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        let row = indexPath.row
        //dataSource[row].isMine == true 내가 쓴 글만 삭제하는 기능을 넣을 때
        return row % 2 == 0 //홀수만 삭제 가능
    }
    
    //셀에서 스와이프를 했을 때, 셀 오른쪽 끝에 나타날 버튼을 지정하는 함수
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //삭제버튼 구현
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { [weak self] (action, view, completion) in
            
            //삭제 이벤트 구현
            let row = indexPath.row
            self?.dataSource.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade) //reload로도 구현 가능함.
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [btnDelete])
    }

    //셀 왼쪽에 나타날 버튼을 구현해주는 함수
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //공유버튼 구현
        let btnShare = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [btnShare])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


}

