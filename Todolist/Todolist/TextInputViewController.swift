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
    //var textInputArray: [String] = []
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        
        guard let createContext = textInput.text else { return }
        textInputArray.append(createContext)
        
        print("現在 array的東西\(textInputArray)")
        textInput.text = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
