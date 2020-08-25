//
//  GetOrderTableViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/6/15.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GetOrderTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let cellId = "cellId"

    var orderName:String!
    var orders = [OrderModel]()
    var ordersDetail = [orderDetail]()
//    var info =  [titleOfsection]()
    var ref: FIRDatabaseReference!
    private var databaseHandle: FIRDatabaseHandle!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        ref = FIRDatabase.database().reference()
        
        
        UIBarButtonItem.appearance().setTitlePositionAdjustment(UIOffset(horizontal: 100, vertical: 30), for: UIBarMetrics.default)
        //self.navigationItem.titleView = UIView(frame: (CGRectMake(10, 1, 50, 10)))
        let attributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 21)!
            
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        
        
        // Cart Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(TableViewController.cartScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
        
        // Hide Back Button - to prevent showing two buttons with the same purpose
        self.navigationItem.hidesBackButton = true
        
        fetchOrders()
        
    }

    func fetchOrders() {
        
        databaseHandle = ref.child("order").observe(.value, with: { (snapshot) in
            var neworder = [OrderModel]()
            for order in snapshot.children.allObjects {
                let order = OrderModel(snapshot: order as! FIRDataSnapshot)
                neworder.append(order)
                
            }
            
            self.orders = neworder
            self.tableView.reloadData()
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetOrders", for: indexPath)
        
        let order = orders[indexPath.row]
        
        
        let textlabelname = cell.viewWithTag(1) as! UILabel
        textlabelname.text = order.uEm
        textlabelname.sizeToFit()
        
        let textLabelName = cell.viewWithTag(2) as! UILabel
        textLabelName.text = order.name
        textLabelName.sizeToFit()
        
        let textLabelPrice = cell.viewWithTag(3) as! UILabel
        textLabelPrice.text = String(describing: order.price!)
        textLabelPrice.sizeToFit()
        
        let textLabelQty = cell.viewWithTag(4) as! UILabel
        textLabelQty.text = String(describing: order.qty!)
        textLabelQty.sizeToFit()
        
        let textLabelKey = cell.viewWithTag(5) as! UILabel
        textLabelKey.text = order.autoId
        textLabelKey.sizeToFit()

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let order = orders[indexPath.row]
            order.ref?.removeValue()
        }
    }
    

    

}
