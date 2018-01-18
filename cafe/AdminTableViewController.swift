//
//  AdminTableViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/7/30.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AdminTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
    @IBOutlet weak var tabelView: UITableView!

    
    var orderName:String!
    var orders = [OrderModel]()
    var ordersDetail = [orderDetail]()
    //    var info =  [titleOfsection]()
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        tabelView.delegate = self
        
        ref = Database.database().reference()
        
        
        UIBarButtonItem.appearance().setTitlePositionAdjustment(UIOffset(horizontal: 100, vertical: 30), for: UIBarMetrics.default)
        //self.navigationItem.titleView = UIView(frame: (CGRectMake(10, 1, 50, 10)))
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 21)!
            
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        
        
        // Cart Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "home30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(AdminTableViewController.logoutScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
        
        // Hide Back Button - to prevent showing two buttons with the same purpose
        self.navigationItem.hidesBackButton = true
        
        fetchOrders()
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
//    func change()  {
//
//
//        for i in 0 ..< orders.count {
//            let converted = Date(timeIntervalSince1970: orders[i].timestamp! / 1000)
//
//            let datefor = DateFormatter()
//            datefor.timeZone = TimeZone.current
//            datefor.dateFormat = "hh:mm a"
//            let time = datefor.string(from: converted)
//
//            orders[i].dater?.append(time)
//
//        }
//    }
    
    func fetchOrders() {
        
        databaseHandle = ref.child("order").observe(.value, with: { (snapshot) in
            var neworder = [OrderModel]()
            for order in snapshot.children.allObjects {
                let order = OrderModel(snapshot: order as! DataSnapshot)
                neworder.append(order)
                
            }
            
            self.orders = neworder
            self.tabelView.reloadData()
            
        })
        print(orders)
        
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderry", for: indexPath)
        
        let order = orders[indexPath.row]
        
        
        let textlabelname = cell.viewWithTag(1) as! UILabel
        textlabelname.text = order.uEm
        textlabelname.sizeToFit()
        
        let textLabelName = cell.viewWithTag(2) as! UILabel
        textLabelName.text = order.name
        textLabelName.sizeToFit()
        
        let textLabelIce = cell.viewWithTag(8) as! UILabel
        textLabelIce.text = order.ice
        textLabelIce.sizeToFit()
        
        let textLabelSugar = cell.viewWithTag(9) as! UILabel
        textLabelSugar.text = order.sugar
        textLabelSugar.sizeToFit()

        let textLabelPrice = cell.viewWithTag(3) as! UILabel
        textLabelPrice.text = String(describing: order.price!)
        textLabelPrice.sizeToFit()
        
        let textLabelQty = cell.viewWithTag(4) as! UILabel
        textLabelQty.text = String(describing: order.qty!)
        textLabelQty.sizeToFit()
        
        let textLabelKey = cell.viewWithTag(5) as! UILabel
        textLabelKey.text = String(describing: order.subtotal!)
        textLabelKey.sizeToFit()
        
        let texLabelText = cell.viewWithTag(6) as! UITextView
        texLabelText.text = order.text
        texLabelText.sizeToFit()
        texLabelText.textColor = UIColor.red
        
        let texLabelTotal = cell.viewWithTag(7) as! UILabel
        texLabelTotal.text = order.total
        texLabelTotal.sizeToFit()
        
//        let converted = Date(timeIntervalSince1970: order.timestamp! / 1000)
        let datefor = DateFormatter()
        datefor.timeZone = NSTimeZone.local
        datefor.dateStyle = .long
        datefor.timeStyle = .medium

        let texLabelTime = cell.viewWithTag(10) as! UILabel
        texLabelTime.text = datefor.string(from: Date(timeIntervalSince1970: order.timestamp! / 1000))
        texLabelTime.sizeToFit()
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let order = orders[indexPath.row]
            order.ref?.removeValue()
        }
    }
    
    @objc func logoutScreen() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginPage" ) as UIViewController
            self.present(vc, animated: true, completion: nil)
        }catch{
            print(error)
        }
        
    }
    
    
    
    
}
