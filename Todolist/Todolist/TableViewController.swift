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
    
    //var dataManager: TextInputViewController = TextInputViewController() //delegate 重要
    
    //var contentArray = [String]()
    var contentArray = ["2","3","444"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let uiNib = UINib(nibName: "TodoTableViewCell", bundle: nil)
        
        tableView.register(uiNib, forCellReuseIdentifier: "frankCell")
        
        //dataManager.delegate = self //delegate 重要
        
        //print("好", ObjectIdentifier(dataManager))
        
        //dataManagerB.delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //推開畫面用
        let selectedMessage = contentArray[indexPath.row]
        
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
        
//        let detailViewController = DetailViewController.detailViewControllerForProduct(selectedArticle)
//
//        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
            let controller = segue.destination as! TextInputViewController
            
            controller.delegate = self
            //dataManager.delegate = self
            print("壞", ObjectIdentifier(controller))
            
            //controller.textInput.text = contentArray[tag]
            controller.textFromHomePage = contentArray[tag]
            
            //controller.movieDetail = movieArray[tag]
        }
        else {
            let controller = segue.destination as! TextInputViewController
            
            controller.delegate = self
        }
        
        
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController: DataEnterDelegate {
    
    func userDidEnterInformation(info: String) {
        
        contentArray.append(info)
        
        print("VC1的\(contentArray)")
        self.tableView.reloadData()
    }
 
}
