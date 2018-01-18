//
//  CheckoutViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/4/1.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase



class CheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextViewDelegate, UITextFieldDelegate {
    
    let moc = DataController().managedObjectContext
    var listItems = [NSManagedObject]()
    var dicListItems = [NSDictionary]()


    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCartAmount: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var checkOut: UIButton!
    
    var allProductsTotal: Int!
//    var activeTextView : UITextView!

    
    
    override func viewDidLoad() {
        title = "訂單確認"
        
        // Retrieve the data from Core Data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let dicFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        dicFetchRequest.resultType = .dictionaryResultType
        
        do{
            let results = try moc.fetch(fetchRequest)
            let dicresults = try moc.fetch(dicFetchRequest)
            
            listItems = results as! [NSManagedObject]
            dicListItems = dicresults as! [NSDictionary]
        }
        catch{
            print("Data didn not Retrieve")
        }
 
        // Refresh tableView
        self.tableView.reloadData()
        
        // MARK: - Buttons navigation
        // Home Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "home30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CheckoutViewController.homeScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
        
        totalCartAmount.text = "$ \(String(allProductsTotal))"
        
        
        checkOut.backgroundColor = UIColor.darkGray
        checkOut.layer.cornerRadius = checkOut.frame.height / 2
        checkOut.setTitleColor(UIColor.white, for: .normal)
        checkOut.layer.shadowColor = UIColor.darkGray.cgColor
        checkOut.layer.shadowRadius = 4
        checkOut.layer.shadowOpacity = 0.5
        checkOut.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        textView.delegate = self
        
//        let center: NotificationCenter = NotificationCenter.default

//        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
    
    // Go to Home screen
    @objc func homeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "user" ) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    // Show the data that saved from the previous screen
    override func viewDidAppear(_ animated: Bool) {
        
        // Retrieve the data from Core Data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let dicFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        dicFetchRequest.resultType = .dictionaryResultType

        do{
            let results = try moc.fetch(fetchRequest)
            let dicresults = try moc.fetch(dicFetchRequest)
            
            listItems = results as! [NSManagedObject]
            dicListItems = dicresults as! [NSDictionary]
            
            //let jsonData = try JSONSerialization.data(withJSONObject: dicListItems, options: .prettyPrinted)
            //let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            //if let dictFromJSON = decoded as? [String:String]{
            //    print("dict:\(dictFromJSON)")
            //}
        }
        catch{
            print("Data didn not Retrieve")
        }
        
        // Refresh tableView
        self.tableView.reloadData()
        
        for i in 0 ..< listItems.count {
            print("ListItems\(i): \(listItems[i])")
        }
        
        totalCartAmount.text = "$ \(String(allProductsTotal))"
        

        
        

    }
    
    // MARK: - TableView display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutViewCell", for: indexPath) as! CheckoutViewCell
        
        // Pull the data from the database and display it in the cell
        let item = listItems[indexPath.row] as! Item
        cell.SetProductAttribute(item)
        cell.tag = indexPath.row
        return cell
    }
    
    
    
    // TextField : Resign Key Board
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (text == "\n") {
                textView.resignFirstResponder()
                return false
            }
            return true
    }
    
    
    
    
    
    // Set placeholder in TextField
    
//    func keyboardDidShow(notification: Notification) {
//        let info:NSDictionary = notification.userInfo! as NSDictionary
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        let keyboardY = self.view.frame.size.height - keyboardSize.height
//        let editingTextfiledY: CGFloat! = self.activeTextView?.frame.origin.y
//        if self.view.frame.origin.y >= 0 {
//        if editingTextfiledY > keyboardY - 60 {
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                self.view.frame = CGRect(x:0, y: self.view.frame.origin.y - (editingTextfiledY - (keyboardY - 60)), width:self.view.bounds.width,height: self.view.bounds.height)
//            }, completion: nil)
//        }
//    }
//    }
//        func keyboardWillHide(notification: Notification) {
//        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.view.frame = CGRect(x:0, y:0, width:self.view.bounds.width, height: self.view.bounds.height)
//        }, completion: nil)
//    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
//        activeTextView = textView
        if (textView.text == "備註") {
            textView.text = ""
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "備註"
        }
        textView.resignFirstResponder()
        
    }
    
    // Dismiss Keyboard When Touches Outside
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // function - write data into firebase database.
    func post() {
        
        
        for i in 0 ..< dicListItems.count {
            if i == 0 {
                let name = dicListItems[i].value(forKey: "name") as! String
                let ice = dicListItems[i].value(forKey: "ice") as! String
                let sugar = dicListItems[i].value(forKey: "sugar") as! String
                let price = dicListItems[i].value(forKey: "roundPrice") as! Int
                let qty = dicListItems[i].value(forKey: "qty") as! Int
                let subtotal = qty * price
                let text = textView.text!
                let totalPrice = "總金額 \(String(allProductsTotal!))"
                let timestemp = ServerValue.timestamp()
                
                let user = Auth.auth().currentUser
                let userID = user?.uid
                let userEm = user?.email
                
                
                let NPQ : [String : Any] = ["name" : name,
                                            "price" : price,
                                            "qty" : qty,
                                            "text": text,
                                            "total": totalPrice,
                                            "uid": userID!,
                                            "subtotal": subtotal,
                                            "email": userEm!,
                                            "timestemp": timestemp,
                                            "ice": ice,
                                            "sugar": sugar]
                let dataabaseRef = Database.database().reference()
                
                dataabaseRef.child("order").childByAutoId().setValue(NPQ)
                
            }else{
                let name = dicListItems[i].value(forKey: "name") as! String
                let ice = dicListItems[i].value(forKey: "ice") as! String
                let sugar = dicListItems[i].value(forKey: "sugar") as! String
                let price = dicListItems[i].value(forKey: "roundPrice") as! Int
                let qty = dicListItems[i].value(forKey: "qty") as! Int
                let subtotal = qty * price
                let text = ""
                let totalPrice = ""
                let timestemp = ServerValue.timestamp()
                
                
                let user = Auth.auth().currentUser
                let userID = user?.uid
                let userEm = user?.email
                
                
                let NPQ : [String : Any] = ["name" : name,
                                            "price" : price,
                                            "qty" : qty,
                                            "text": text,
                                            "total": totalPrice,
                                            "uid": userID!,
                                            "subtotal": subtotal,
                                            "email": userEm!,
                                            "timestemp": timestemp,
                                            "ice": ice,
                                            "sugar": sugar]
                let dataabaseRef = Database.database().reference()
                
                dataabaseRef.child("order").childByAutoId().setValue(NPQ)
            }

        }
        


    }
    // function of delete coredata
    func dele() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            try moc.execute(request)
        }
        catch{
            print("no")
        }
    }
    func logoutScreen() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginPage" ) as UIViewController
            self.present(vc, animated: true, completion: nil)
        }catch{
            print(error)
        }
        
    }

    
    // MARK:Button of post Order
    @IBAction func subOrder(_ sender: Any) {
        
        let myAlert: UIAlertController = UIAlertController(title: "您確定要送出訂單了嗎？", message: "確認備註與甜度冰塊都沒有問題了嗎？", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "ok", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            self.post()
            self.dele()
            self.logoutScreen()
            
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "user" ) as UIViewController
            //self.present(vc, animated: true, completion: nil)
            self.performSegue(withIdentifier: "VC2", sender: self)

            }
        )
        myAlert.addAction(submitAction)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        myAlert.addAction(cancelAction)
        
        
        self.present(myAlert, animated: true, completion: nil)
        
        
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    
    }
    
    

}
