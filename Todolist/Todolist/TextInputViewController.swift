//
//  TextInputViewController.swift
//  Todolist
//
//  Created by Frank on 2018/8/28.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class TextInputViewController: UIViewController {
    
    var textInputArray = [String]()
    var textFromHomePage = ""
    //var textInputArray: [String] = [] 和上面的差別是？
    
    //@IBOutlet weak var myNavigationItem: UIView!
    
    var chooseType: ChooseType = ChooseType.add //OK
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        
        
        guard let createContext = textInput.text else { return }
        
        //textInputArray.append(createContext)
        //delegate?.userDidEnterInformation(info: createContext)

        //print("現在 array的東西\(textInputArray)")
        
        //if else 來判斷有沒有值的話不行 Edit add 按下去的瞬間都有值
        
        //let notificationName = Notification.Name("psssData")
        
        switch chooseType {

        case .Edit:
            
            NotificationCenter.default.post(name: .pass, object: nil, userInfo: ["status": "editData", "textInput": createContext ])
        case .add:
            
            NotificationCenter.default.post(name: .pass, object: nil, userInfo: ["status": "addData", "textInput": createContext ])
            //NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["status": "addData", "textInput": createContext ]) 原本
            
                   //textInput.text = ""
        }
        
//        if editContentCreatGoalVC == nil{
//            let notificationName = Notification.Name("dataUpdated")
//            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["goalText":goalTextView.text])
//        }else{
//            let notificationName = Notification.Name("editUpdated")
//            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["editText":goalTextView.text])
//        }
//        dismissDetail()
        
        //加一個推回去的 func
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if textFromHomePage != "" {
            textInput.text = textFromHomePage
            chooseType = .Edit  //改變目前狀態
        }
        
        changeTitle()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeTitle() {
        if textFromHomePage != "" {
            self.title = "EditPage"
            
        }
        else {
            self.title = "AddPage"
        }
    }

}


enum ChooseType: String {
    
    case add = "Add"
    case Edit = "Edit"

}

extension Notification.Name {
    
    static let pass = Notification.Name("pass")
    static let edit = Notification.Name("edit")
    static let add = Notification.Name("add")
    
}
