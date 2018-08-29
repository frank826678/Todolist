//
//  TableViewController.swift
//  Todolist
//
//  Created by Frank on 2018/8/28.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // UITableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
    
    //不能拉在另外一頁 why ? 下面暫時沒用到 用另外一個判斷式
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    
    //var contentArray = [String]() 初始值是空的
    var contentArray = ["1","223","333444","第四筆資料"]
    
    var nowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let uiNib = UINib(nibName: "TodoTableViewCell", bundle: nil)
        
        tableView.register(uiNib, forCellReuseIdentifier: "frankCell")
        
         //let notificationName = Notification.Name("psssData")
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataProccess(notifi:)), name: .pass, object: nil)
    }

    @objc func dataProccess(notifi:Notification) {
        let status = notifi.userInfo!["status"] as! String
        let passData = notifi.userInfo!["textInput"] as! String
        if status == "addData" {
            
            contentArray.append(passData)
            
        } else {
            
            contentArray[nowIndex] = passData
            //contentArray.remove(at: nowIndex)
            //contentArray.insert(info, at: nowIndex)
            
        }
        print("VC1的\(contentArray)")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contentArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "frankCell", for: indexPath) as?
            TodoTableViewCell else {
                return UITableViewCell() }
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        cell.todoLabel.text = contentArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //推開畫面用 這邊沒用到
        
        //let selectedMessage = contentArray[indexPath.row]
        
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
        
//        let detailViewController = DetailViewController.detailViewControllerForProduct(selectedArticle)
//
//        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 100 //這樣初次載入會跑比較快
        return UITableViewAutomaticDimension
    
    }
    
    @objc func buttonClicked(sender: UIButton) {
        
        //let buttonRow = sender.tag
        //換頁成功 由 storyboard 拉 segue 並且下面名稱與外面一樣
        self.performSegue(withIdentifier: "EditPage", sender: sender.tag)
        print("目前狀況\(sender)")
        //myNavigationItem.title = "EditPage"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditPage" {
            
            let tag = sender as! Int
            nowIndex = tag //把目前選到的ＥＤＩＴ 放到全域去準備使用
            let controller = segue.destination as! TextInputViewController
            
            //print("壞", ObjectIdentifier(controller))
            
            //controller.textInput.text = contentArray[tag]
            controller.textFromHomePage = contentArray[tag]
            
            //controller.movieDetail = movieArray[tag]
        }
        else {
            
            let controller = segue.destination as! TextInputViewController
            
           
        
        }
    }
}

//extension TableViewController: DataEnterDelegate {
//    
//    func newCreateNewComment(info: String) {
//        
//        contentArray.append(info)
//        
//        print("VC1的\(contentArray)")
//        self.tableView.reloadData()
//        
//    }
//    
//    
//    func userDidEnterInformation(info: String) {
//        
//        contentArray.remove(at: nowIndex)
//        contentArray.insert(info, at: nowIndex)
//        print("VC1的\(contentArray)")
//        self.tableView.reloadData()
//        
//    }
//}
