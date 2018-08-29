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
    //var editMovie = MovieDetail() //第一頁傳值過來
    
    weak var delegate: DataEnterDelegate?
    //weak var delegate: TableViewController?
    
    var chooseType: ChooseType = ChooseType.add //OK
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        
        
        //guard let createContext = textInput.text else { return }
        
        //textInputArray.append(createContext)
        //delegate?.userDidEnterInformation(info: createContext)

        //print("現在 array的東西\(textInputArray)")
        
        //if else 來判斷有沒有值的話不行 Edit add 按下去的瞬間都有值
        
        switch chooseType {
            
        case .Edit:
            delegate?.userDidEnterInformation(info: textInput.text!) //.text後 要求補驚嘆號或問號
        case .add:
            delegate?.newCreateNewComment(info: textInput.text!) //delegate後自動補問號,.text後 要求補驚嘆號或問號, Ans: delegate 是一個 optional
        //textInput.text = ""
        }
        
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

protocol DataEnterDelegate: AnyObject{
    
    func userDidEnterInformation(info:String)
    
    func newCreateNewComment(info:String)
    
}

enum ChooseType: String {
    
    case add = "Add"
    case Edit = "Edit"

}
