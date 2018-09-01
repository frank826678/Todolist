# Todolist

#1.Delegate

-----
VC2 傳值到 VC1

先在 VC2 創建 protocol 並 conform `Anyobject` 

並且創建一個 delegate conform 這個 protocol

`    weak var delegate: DataEnterDelegate? `

```
protocol DataEnterDelegate: AnyObject{
    
    func userDidEnterInformation(info:String)
    
    func newCreateNewComment(info:String)
    
}

enum ChooseType: String {
    
    case add = "Add"
    case Edit = "Edit"

}
```

執行 method

```

switch chooseType {
            
        case .Edit:
            delegate?.userDidEnterInformation(info: textInput.text!) //.text後 要求補驚嘆號或問號
        case .add:
            delegate?.newCreateNewComment(info: textInput.text!) //delegate後自動補問號,.text後 要求補驚嘆號或問號, Ans: delegate 是一個 optional
        //textInput.text = ""
        }

```

------
在 VC1 下，注意放 delegate 的位置，需要放在 new 出來的 controller 這，否則只會是不同的記憶體位置，導致無法找到對方，沒有建成溝通的橋樑。


```
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditPage" {
            
            let tag = sender as! Int
            nowIndex = tag //把目前選到的ＥＤＩＴ 放到全域去準備使用
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

```

VC1 定義實際執行這個 method 的內容


```
extension TableViewController: DataEnterDelegate {
    
    func newCreateNewComment(info: String) {
        
        contentArray.append(info)
        
        print("VC1的\(contentArray)")
        self.tableView.reloadData()
        
    }
    
    
    func userDidEnterInformation(info: String) {
        
        contentArray.remove(at: nowIndex)
        contentArray.insert(info, at: nowIndex)
        print("VC1的\(contentArray)")
        self.tableView.reloadData()
        
    }
}

    
```

----

# 2.Notification
----

可以用 `extension` 來拓展 name
很大的好處是當我們使用 name 時 不會發生打錯字的情況 只需要用 ``.`` 呼叫。


```
extension Notification.Name {
    
    static let pass = Notification.Name("pass")
    static let edit = Notification.Name("edit")
    static let add = Notification.Name("add")
    
}

```

----

這邊用了 `userinfo` 所夾帶的字典檔來判斷為哪一個狀態，這樣只需要一個 `post` 一個 `observer` 就可以判斷現在是 `edit` or `add` 的狀態。

```
case .Edit:
            
            NotificationCenter.default.post(name: .pass, object: nil, userInfo: ["status": "editData", "textInput": createContext ])
case .add:
            
            NotificationCenter.default.post(name: .pass, object: nil, userInfo: ["status": "addData", "textInput": createContext ])
            
```
            
-------
在 viewDidLoad 下，註冊 observer， 

`NotificationCenter.default.addObserver(self, selector: #selector(dataProccess(notifi:)), name: .pass, object: nil)
`
以下為收到通知後要做的事情

```
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
    
```

補充：當要改變 `array` 裡面的某個值時，可以使用 `=` 直接改變，不需要先 `remove` 再 `insert`！

-----       

# 3.KYO
-----

要被監控的對象前面要加上 `@objc dynamic ` 範例如下：

`    @objc dynamic var infoInput: String?`

當他改變時，我們要決定在哪邊放監控 `addobserver` 的位置，範例如下：


```
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditPage" {
            
            let tag = sender as! Int
            nowIndex = tag //把目前選到的ＥＤＩＴ 放到全域去準備使用
            let controller = segue.destination as! TextInputViewController
            
            controller.textFromHomePage = contentArray[tag]
            
            //KVO
            controller.addObserver(self, forKeyPath: "infoInput", options: .new, context: nil)

            
        }
        else {
            
            let controller = segue.destination as! TextInputViewController
            controller.addObserver(self, forKeyPath: "infoInput", options: .new, context: nil)
        
        }
    }
    
```
當他改變時，我們要所要執行的 method 範例如下：


```
    //KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let change = change else { return }
        
        if let data = change[NSKeyValueChangeKey.newKey] as? String {
            
            if let index = nowIndex {
                contentArray[index] = data
                nowIndex = nil
                self.tableView.reloadData()

            } else {
                contentArray.append(data)
                self.tableView.reloadData()
            }
            
        }
    }
    
```
------


# 4.Closure
----

利用以下程式碼來接資料 注意要有 `=`

```
            controller.completionHandler = { dataFromVC2 in
                
                self.saveData(passData: dataFromVC2)
                
            }
```






```
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditPage" {
            
            let tag = sender as! Int
            nowIndex = tag //把目前選到的ＥＤＩＴ 放到全域去準備使用
            let controller = segue.destination as! TextInputViewController
            
            
            controller.textFromHomePage = contentArray[tag]
            
            controller.completionHandler = { dataFromVC2 in
                
                self.saveData(passData: dataFromVC2)
                
            }
        }
        else {
            
            let controller = segue.destination as! TextInputViewController
           
            controller.completionHandler = { dataFromVC2 in
                
                self.saveData(passData: dataFromVC2)
                
            }
        }
    }
    
    
```

在 VC2 需要先宣告他的型別，並將要傳入的資料輸入

```
//closue
    var completionHandler: ((String) -> Void)?
```    

```
//closure
        
        //completionHandler?(infoInput ?? "")
        completionHandler!(infoInput!)
        
```        

