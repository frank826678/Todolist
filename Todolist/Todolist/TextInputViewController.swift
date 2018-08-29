//
//  TextInputViewController.swift
//  Todolist
//
//  Created by Frank on 2018/8/28.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class TextInputViewController: UIViewController {
    
    //var textInputArray = [String]()
    var textFromHomePage = ""
    
    @objc dynamic var infoInput: String?
    
    //var textInputArray: [String] = [] 和上面的差別是？
    //@IBOutlet weak var myNavigationItem: UIView!
     
    var chooseType: ChooseType = ChooseType.add //OK
    
    //closue
    var completionHandler: ((String) -> Void)?
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        
        infoInput =  textInput.text
        
        //closure
        //completionHandler?(infoInput ?? "")
        completionHandler!(infoInput!)
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
